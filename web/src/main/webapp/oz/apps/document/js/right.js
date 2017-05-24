!function() {

	var RightPage = function() {

	};

	RightPage.prototype.setState = function(state) {

	}

	RightPage.prototype.toggle = function() {

	}

	var _rightsData = null;
	var _factorIndex = "";
	// 当前的环节权限
	var _rights;

	// 初始化权限配置信息

	function loadRightData() {
		var id = defId;
		if (null == id || id <= 0)
			return;

		$.getJSON(contextPath + "/document/def/rightAction.do?action=loadRights&timeStamp=" + new Date().getTime(), {
			id : defId
		}, function(json) {
			if (json.result) {
				_rightsData = json.data;
				buildRightHtml();
				buildAddActivityFactor();
				buildFactorHtml();
			} else {
				_rightsData = null;
				$("#elementRights").empty();
			}
		});
	}

	function buildRightHtml() {
		var elementHtml = buildElementHtml(_rightsData.elements).join("");
		$("#elementRights").html(elementHtml);
	}

	function buildAddActivityFactor() {
		var html = "", list = _rightsData.activityFactor.factors;
		$.each(list, function(index, d) {
			if (index == 0) {
				return;
			}
            if(d.type == "folder"){
                html += '<li class="nav-header"><strong>' + d.name + '</strong></li>';
            }else{
	    		html += '<li><a href="#"  class="addFactor" cmd="addActivity" key="' + d.key + '">' + d.name + '</a></li>';
            }
		});
		$("#addFactorList").append(html);
	}

	function buildFactorHtml() {
		if ($("#" + _factorType).data("loaded")) {
			return;
		}
		var factorType = _rightsData[_factorType].type;
		var factors = _rightsData[_factorType].factors;
		$("#" + _factorType + " .factor-list").append(buildLeftHtml(factors, factorType));
		if (factors.length > 0) {
			assignRightBox("0");
		}
		$("#" + _factorType).data("loaded", true);
	}

	function buildLeftHtml(list, factorType) {
		var html = "";
		$.each(list, function(index, d) {
            var folder  = (d.type == "folder");
            if(folder){
                html += '<li index="' + index + '" key="' + d.key + '" class="right-factor-folder nav-header ' + (index == 0 ? "active" : "")
                    + '">' + d.name + '</li>';
            }else{
                if (editable && factorType != "activity") {
                    html += '<li index="' + index + '" key="' + d.key + '" cmd="switchFactor" class="right-factor ' + (index == 0 ? "active" : "")
                        + '"><a href="#"><button class="close" href="#">&times;</button>' + d.name + '</a></li>';
                } else {
                    html += '<li index="' + index + '" key="' + d.key + '" cmd="switchFactor" class="right-factor ' + (index == 0 ? "active" : "")
                        + '"><a href="#"><i class=" icon-chevron-right"></i>' + d.name + '</a></li>';
                }
            }
		});
		return html;
	}

	/**
	 * 构建ElementHtml
	 */

	function buildElementHtml(elements) {
		var lis = [];
		$.each(elements, function(index, d) {
			lis.push("<div index='" + index + "' key='" + d.key + "' class='element-row'>");
			lis.push("<div class='row'>");

			// Label
			lis.push("<div class='span3 element-item" + (d.level == 0 ? " top" : "") + " ' title='" + d.name + "'>");
			for ( var i = 0; i < d.level; i++) {
				lis.push("&nbsp;&nbsp;");
			}
			lis.push(d.name);
			lis.push("</div>");

			// Columu1
			lis.push('<div class="span6 row">');
			for ( var int = 0; int < d.rights.length; int++) {
				var right = d.rights[int];
				lis.push("<div class='right-span'>");
				if (right) {
					lis.push('<label class="checkbox">');
					if(editable){
						lis.push('<input type="checkbox" class="rightbox" name="' + d.key + '" value="' + right.right + '" />');
					}else{
						lis.push('<input type="checkbox" class="rightbox" name="' + d.key + '" value="' + right.right + '" disabled="disabled" />');
					}
					lis.push(right.label + '</label>');
				}
				lis.push("</div>");
			}
			lis.push("</div>");

			lis.push("</div>");

			if (d.children) {
				var cs = buildElementHtml(d.children);
				if (cs && cs.length > 0) {
					lis.push("<div class=''>");
					Array.prototype.push.apply(lis, cs);
					lis.push("</div>");
				}
			}

			lis.push("</div>");
			lis.push("\n");

		});
		return lis;
	}
	/**
	 * 显示权限值
	 */
	function assignRightBox(factorIndex) {
		if (factorIndex == -1) {
			$(".element-row :checkbox:not(:disabled)").attr("checked", false);
			return;
		}
		var matrix = getRightMatrix();
		if (!matrix || !matrix[factorIndex]) {
			$(".element-row :checkbox:not(:disabled)").attr("checked", false);
			return;
		}
		var elements = _rightsData.elements;
		$.each(elements, function(index, d) {
			var right = matrix[factorIndex][index];
			$(".element-row[key='" + d.key + "']").find(":checkbox").each(function() {
				var r = $(this).val();
				$(this).attr("checked", (right & r) == r);
			});
		});
		_factorIndex = factorIndex;
	}

	/**
	 * 保存环节的权限
	 */

	function saveFactorRight(factorIndex) {
		if (factorIndex === -1) {
			return;
		}
		var elements = _rightsData.elements;
		$.each(elements, function(index, d) {
			setFactorRight(factorIndex, d.key)
		})
	}
	/**
	 * 设置权限的值
	 */

	function setFactorRight(factorIndex, key) {
		if (factorIndex === -1 || key < 0) {
			return;
		}
		var matrix = getRightMatrix();
		var right = 0;

		var row = $(".element-row[key='" + key + "']");
		row.find(":checkbox:checked").each(function() {
			var $this = $(this);
			var r = $this.val();
			right = right | r;
		});
		matrix[factorIndex][parseInt(row.attr("index"))] = right;
	}

	/**
	 * 获取权限矩阵
	 */
	function getRightMatrix() {
		var rights = getFactorData().rights;
		return rights;
	}

	function getFactorData() {
		if (_rightsData[_factorType] === undefined) {
			_rightsData[_factorType] = {};
		}
		if (_rightsData[_factorType].factors === undefined) {
			_rightsData[_factorType].factors = [];
		}
		if (_rightsData[_factorType].rights === undefined) {
			_rightsData[_factorType].rights = [];
		}
		return _rightsData[_factorType];
	}

	/**
	 * 添加factor
	 */
	function addFactor(factorIndex, factor) {
		var factorData = getFactorData();
		var elements = _rightsData.elements;
		var right = $.map(elements, function() {
			return 0;
		});
		factorData.rights.splice(factorIndex, 0, right);
		factorData.factors.splice(factorIndex, 0, factor);
	}

	/**
	 * 添加factor
	 */
	function removeFactor(factorIndex) {
		var factor = _rightsData[_factorType];
		if (factor == undefined) {
			return;
		}
		if (factor.factors == undefined) {
			return;
		}
		if (factor.rights == undefined) {
			return;
		}
		factor.rights.splice(factorIndex, 1);
		factor.factors.splice(factorIndex, 1);
	}

	function selectFactor(el) {
		var $this = $(el);
		if ($this.hasClass('active'))
			return;
		$this.addClass("active").siblings().removeClass('active');
		assignRightBox($this.index());

		// $("#selectRightBox :checkbox[name=selectRight]").each(function() {
		// var size = $(".element-row").find(":checkbox:eq(" + $(this).val() +
		// "):not(:disabled):not(:checked)").size();
		// $(this).attr("checked", size == 0);
		// });
		return;
	}

	function addToFactor(factor) {
		var $factor = null;
		$factor = $("#" + _factorType + " .right-factor[key='" + factor.key + "']");
		if ($factor.size() > 0) {
			return;
		}
		$factor = $('<li key="' + factor.key + '" cmd="switchFactor" class="right-factor"><a href="#"><button class="close" href="#">&times;</button>'
				+ factor.name + '</a></li>');
		$("#" + _factorType + " .factor-list").append($factor);
		var index = $factor.index();
		addFactor(index, factor);
		return $factor;
	}

	function addSystemUserFactor() {
		OZ.Organize.addressBook(function(result) {
			var $factor = null;
			//$.each(result, function(index, d) {
				var factor = {
					key : result.id,
					name : result.name
				};
				$factor = addToFactor(factor);
			//});
			selectFactor($factor);
		});
	}

	function addFactorSelect(key, name) {
		var factor = {
			key : key,
			name : name
		};
		selectFactor(addToFactor(factor));
	}

	var _factors = [ "activityFactor", "activityDoneFactor", "sidFactor", "sidTodoFactor" ];
	var _factorType = "";

	function setTabData(index) {
		_factorType = _factors[index];
	}

	$(function() {

		$(".ui-tab").oTabs().bind("select", function(e, index) {
			setTabData(index);
			if (_rightsData) {
				buildFactorHtml();
				_factorIndex = $("#" + _factorType + " .factor-list .active").index();
				assignRightBox(_factorIndex);
			}
		});

		loadRightData();

		// bingding事件
		// 选择左边元素
		$(".factor-list").on("click", "li.right-factor", function() {
			return selectFactor(this);
		});
		if (editable) {
			// 删除
			$(".factor-list").on("click", "li.right-factor .close", function() {
				var $factor = $(this).parent().parent();
				var index = $factor.index();
				OZ.Msg.confirm("确认删除" + $factor.text().substring(1), function() {
					$factor.remove();
					removeFactor(index);
					selectFactor(-1);
				});
				return false;
			});

			// 修改权限操作
			$("#elementRights").on("click", ".rightbox", function(event) {
				if (_factorIndex == -1) {
					return false;
				}
				setFactorRight(_factorIndex, $(this).attr("name"));
			});
			// 全选操作
			$("#selectRightBox").on("click", ":checkbox[name=selectRight]", function(event) {
				if (_factorIndex == -1) {
					return false;
				}
				var $this = $(this);
				var selectRight = $this.val();
				var checked = this.checked;
				$("#elementRights").find(".element-row").find(":checkbox:eq(" + selectRight + "):not(:disabled)").attr("checked", checked);
				saveFactorRight(_factorIndex);
			});
		
			// 添加的操作
			$(".nav-header").on("click", ".addFactor", function(event) {
				var $this = $(this);
				var cmd = $this.attr("cmd");
				if (cmd == "addSystemUser") {
					addSystemUserFactor();
				} else if (cmd == "addDocUser") {
					addFactorSelect("doc_user", $this.text());
				} else if (cmd == "addDocViewer") {
					addFactorSelect("doc_viewer", $this.text());
				} else if (cmd == "addDocAdmin") {
					addFactorSelect("doc_admin", $this.text());
				} else if (cmd == "addActivity") {
					addFactorSelect($this.attr("key"), $this.text());
				}
			});
		}
	});

	/**
	 * 复制权限
	 */
	function copyRight() {
		var matrix = getRightMatrix();
		_rights = matrix[_factorIndex];
		if (_rights) {
			$("#applyRightBtn").attr("disabled", false);
		}
	}

	/**
	 * 应用复制的权限
	 */
	function applyRight() {
		if (!_rights) {
			alert("请先复制源环节的权限。");
			return;
		}
		var matrix = getRightMatrix();
		var rights = matrix[_factorIndex] = _rights;
		assignRightBox(_factorIndex);
	}
	/**
	 * 保存前将用户设置的权限进行序列化
	 */
	function onSaveRight() {
		var rightsStr = [];
		var elements = _rightsData.elements;
		$.each(_factors, function(index, factorType) {
			var factor = _rightsData[factorType];
			var factors = _rightsData[factorType].factors;
			var rights = _rightsData[factorType].rights;
			for ( var ei = 0; ei < elements.length; ei++) {
				for ( var si = 0; si < factors.length; si++) {
					var r = (rights[si][ei] || 0);
					if (r == 0) {
						continue;
					}
					rightsStr.push(elements[ei].key + ":" + factors[si].key + ":" + (rights[si][ei] || 0) + ":" + factor.type + ":" + factors[si].name)
				}
			}
		});
		var id = defId;
		if (null == id || id <= 0)
			return;
		$.post(contextPath + "/document/def/rightAction.do?action=save&timeStamp=" + new Date().getTime(), {
			id : defId,
			rights : rightsStr.join(",")
		}, function(json) {
			if (json.result) {
				alert("保存成功.");
			} else {
				alert("保存失败.");
			}
		}, "json");
		return true
	}

	this.onSaveRight = onSaveRight;
	this.copyRight = copyRight;
	this.applyRight = applyRight;
	this.loadRightData = loadRightData;
}();
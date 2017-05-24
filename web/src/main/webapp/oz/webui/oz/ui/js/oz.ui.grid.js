//Gird
(function ($) {
    OZ.define("OZ.data.Store", {
        currentPage: 1,
        pageSize: 25,
        totalCount: 0,
        sortname: "",
        sortorder: "",
        query: "",
        qtype: "",
        params: [],
        load: function () {
            var me = this;
            if (me.proxy) {
                if (me.proxy.url) {
                    me.fireEvent("beforeload");
                    var param = [{
                        name: 'page',
                        value: me.currentPage
                    }, {
                        name: 'pageSize',
                        value: me.pageSize
                    }, {
                        name: 'sort',
                        value: me.sortname
                    }, {
                        name: 'order',
                        value: me.sortorder
                    }, {
                        name: 'query',
                        value: me.query
                    }, {
                        name: 'qtype',
                        value: me.qtype
                    }];
                    if (me.params && me.params.length) {
                        for (var pi = 0; pi < me.params.length; pi++) {
                            param.push(me.params[pi]);
                        }
                    }
                    $.ajax({
                        type: "post",
                        url: me.proxy.url,
                        async: true,
                        data: param,
                        dataType: 'json',
                        success: function (json) {
                            me.totalCount = json.total;
                            me.loadData(json.rows);
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            try {
                                if (p.onError) p.onError(XMLHttpRequest, textStatus, errorThrown);
                            } catch (e) {

                            }
                            me.totalCount = 0;
                            me.loadData([]);
                            me.fireEvent("loadfail");
                        }
                    });
                }
            }
        },
        loadPage: function (page) {
            var me = this,
                maxpage = Math.ceil(me.totalCount / me.pageSize);
            page = Math.min(Math.max(1, page), maxpage);
            this.currentPage = page;
            this.load();
        },
        loadData: function (data, append) {
            var me = this;
            me.pageSize = me.pageSize || 25;
            me.data = me.data || [];
            if (append) {
                $.merge(me.data, data);
            } else {
                me.data = data;
            }
            
            me.from = (me.currentPage - 1) * me.pageSize + 1;
            me.to = me.from + me.pageSize - 1;
            if (me.totalCount < me.to) {
                me.to = me.totalCount;
            }
            me.pages = Math.ceil(me.totalCount / me.pageSize);
            me.fireEvent("datachange");
        },
        getData: function () {
            return this.data;
        },
        getPage: function () {
            return this.data;
        },
        /**
         * 获取记录在第几页
         */
        getPageFromRecordIndex: function (index) {
            return Math.floor(index / this.pageSize) + 1;
        },
        getTotalCount: function () {
            return this.totalCount;
        },
        getCount: function () {
            return this.data.length || 0;
        },
        /**
         * 加载上一页数据
         */
        previousPage: function () {
            this.loadPage(this.currentPage - 1);
        },
        /**
         * 加载下一页数据
         */
        nextPage: function () {
            this.loadPage(this.currentPage + 1);
        },
        sort: function (p, dir,skipClear) {
        	if(!skipClear){
        		   this.sortname = p;
                   this.sortorder = dir;
        	}else{
        		var sorts = this.sortname.split(",");
        		var dirs = this.sortorder.split(",");
        		var i = $.inArray(p,sorts)
        		if(i==-1){
        			sorts.push(p);
        			dirs.push(dir);
        		}else{
        			sorts[i] = p;
        			dirs[i] = dir;
        		}
        		this.sortname = sorts.join(',');
        		this.sortorder = dirs.join(',');
        	}
            this.load();
        }
    });

    /**
     * 表格的头
     */
    OZ.widget("OZ.grid.Header", OZ.Mouse, {
        statics: {
            columnTpl: [
                '<div class="oz-column-header">',
                    '<div class="oz-column-header-inner">',
                        '<span class="oz-column-header-text">${(this.inner||"&#160")}</span>',
                    '</div>',
                '</div>'
                ].join("")
        },
        $type: "gridheader",
        options: {
            possibleSortStates: ['ASC', 'DESC']
        },
        _render: function () {
            var me = this,
                el = this.el;
            el.addClass("oz-grid-header").append('<div class="oz-box-inner"/>');
            me.inner = el.find(".oz-box-inner");

            var opts = me.options;
            var items = opts.items;
            var sortColIds = [];
            var sorts  = opts.sortname.split(",");
            var dirs  = opts.sortorder.toUpperCase().split(",");
            if (items) {
                $.each(items, function (index, item) {
                    var renderit = $.extend({}, item);
                    renderit.inner = renderit.text;
                    if (renderit.checkbox == true) {
                        renderit.inner = "<b class='oz-grid-checkbox'></b>&#160";
                    }                    
                    var col = $($.render(OZ.grid.Header.columnTpl, renderit));
                    col.width(renderit.width || 30);
                    col.data("item", renderit);
                    col.data("render", renderit);
                    col.id("gridcolumn-");
                    me.inner.append(col);
                    if(!item.dataIndex && !item.sortable){
                    	item.sortable = false;
                    }else{
                    	if($.inArray(item.dataIndex,sorts) > -1){
                    		sortColIds.push(col.attr("id"));
                    	}
                    }
                });
            }
            this._mouseInit();
            me.headers = el.find(".oz-column-header");
        	for(var i=0;i<sortColIds.length;i++){
        		me.setSortState(me.headers.filter("#"+sortColIds[i]),dirs[i]||"DESC",true);
        	}
        },
        _init: function () {
            var me = this,
                el = me.el,
                opts = me.options,
                items = opts.items;

            me.headers.live("mousemove", function (e) { //判定调整的列
                $(".oz-column-header-inner", this).addClass("oz-column-header-over");
                if (me.dragging) {
                    if (me.activeHd) {
                        me.activeHd.css({
                            cursor: ''
                        });
                        delete me.activeHd;
                    }
                } else {
                    var jel = $(this),
                        resizeHeader, posLeft = e.pageX - jel.offset().left,
                        currentLeft = 0;
                    if (posLeft >= 0 && posLeft <= 5) { //鼠标是否在列的前段
                        //如果不是第一列，则调整的前面的列。
                        if (jel.prev().size() > 0) {
                            resizeHeader = jel.prev();
                        }
                    } else if (posLeft >= (jel.outerWidth() - 5) && posLeft <= jel.outerWidth()) { //鼠标列的后面位置，则调整当前列
                        resizeHeader = jel;
                    } else { //不做调整
                        resizeHeader = null;
                    }
                    //找到可调整的列
                    if (resizeHeader) {
                        jel.css({
                            cursor: 'e-resize'
                        });
                        me.activeHd = resizeHeader;
                    } else {
                        jel.css({
                            cursor: ''
                        });
                        delete me.activeHd;
                    }
                }
            }).live("mouseout", function (e) {
                $(".oz-column-header-inner", this).removeClass("oz-column-header-over");
                if (me.dragging) {
                    return; // 如果正在调整列宽
                }
                $('body').css({
                    cursor: ''
                });
            }).live("click", function (e) { //排序
                var opts = me.options,
                    idx, nextIdx;
                var item = $.data(this, "item");
                if (item.sortable) {
                    idx = $.inArray($(this).data("sortState"), opts.possibleSortStates);
                    nextIdx = (idx + 1) % opts.possibleSortStates.length;
                    me.setSortState(this, opts.possibleSortStates[nextIdx],e.ctrlKey);
                }
            }).live("mousedown", function (e) {
                me.el.disableSelection();
            }).live("mouseup", function (e) {
                me.el.enableSelection();
            });
            
            // 全选按钮
            me.el.find(".oz-grid-checkbox").parent().click(function () {
                $(this).toggleClass("oz-grid-header-selected");

                if ($(this).hasClass("oz-grid-header-selected")) {
                    $(me.el.parent()).find(".oz-grid-row").addClass("oz-grid-row-selected");
                } else {
                    $(me.el.parent()).find(".oz-grid-row").removeClass("oz-grid-row-selected");
                }
            });
            this.layout();
        },
        /**
         * 设置排序状态
         */
        setSortState: function (column, sort, skipClear) {
            var me = this,
                colSortClsPrefix = 'oz-column-header-sort-',
                ascCls = colSortClsPrefix + 'ASC',
                descCls = colSortClsPrefix + 'DESC',
                nullCls = colSortClsPrefix + 'null';
            $(column).removeClass(ascCls + " " + descCls + " " + nullCls).addClass(colSortClsPrefix + sort);
            if (!skipClear) {
                me.clearOtherSortStates(column)
            }
            $(column).data("sortState", sort);
            this._trigger("sortchange", null, [column, sort , skipClear]);
        },
        clearOtherSortStates: function (column) {
            var me = this;
            me.headers.each(function () {
                if (this != column) {
                    me.setSortState(this, null, true);
                }
            })
        },
        layout: function () {
            var me = this,
                width = 0,
                height = 20,
                left;
            me.headers.each(function () {
                var h = $(this),
                    d = $.data(this, "item");
                $(this).css("left", width);
                width += $(this).outerWidth();
                height = Math.max(height, $(this).outerHeight());
            });
            me.fullWidth = width;
            me.inner.width(width + 2 + (OZ.getScrollBarWidth() + ($.browser.msie ? 1 : 0)));
            me.inner.height(height);
            me._trigger("layout");
        },
        _mouseCapture: function (event) {
            return !!this.activeHd;
        },
        _mouseStart: function (event) {
            var me = this,
                header = me.el;
            me.dragHd = me.activeHd;
            if (!me.dragHd) {
                return false;
            }
            me.dragging = true;

            $('body').disableSelection();

            var grid = $(me.el.parent()),
                lm = grid.grid("getLhsMarker"),
                rm = grid.grid("getRhsMarker"),
                markerHeight = header.outerHeight() + grid.grid("getBody").outerHeight(),
                top = me.el.position().top,
                offsetLeft = me.dragHd.offset().left - grid.offset().left - grid.border().left,
                width = this.dragHd.width();
            lm.css({
                top: top,
                height: markerHeight,
                left: offsetLeft
            });
            rm.css({
                top: top,
                height: markerHeight,
                left: offsetLeft + width
            });
        },
        _mouseDrag: function (event) {
            var me = this,
                grid = $(me.el.parent()),
                rm = grid.grid("getRhsMarker"),
                pointx = event.pageX,
                offsetLeft = grid.offset().left;
            rm.css({
                left: pointx - offsetLeft
            });
        },
        _mouseStop: function (event) {
            this.dragging = false;
            if (this.dragHd) {
                var me = this,
                    grid = $(me.el.parent()),
                    lm = grid.grid("getLhsMarker"),
                    rm = grid.grid("getRhsMarker");
                lm.css({
                    left: -9999
                });
                rm.css({
                    left: -9999
                });
                me.dragHd.width(me.dragHd.width() - (me._mouseDownEvent.pageX - event.pageX));
                me.layout();
                me._trigger("columnresize", event, {
                    column: me.dragHd
                });
            }
            $('body').enableSelection();
        },
        getFullWidth: function () {
            return this.fullWidth;
        },
        getHeaders: function () {
            return this.inner.find(".oz-column-header");
        }
    });

    /**
     * 表格的视图对象
     */
    OZ.widget("OZ.grid.View", {
        $type: "gridview",
        options: {
            currentPage: 1,
            count: 0,
            /**
             * 缓存的页数
             */
            cacheSize: 2
        },
        _render: function () {
            this.el.addClass("oz-grid-view");
            var viewHtml = ["<div class='oz-grid-table-ct'>",
                                                "<div class='oz-grid-table-head'/>",
                                                "<div class='oz-grid-table-foot'/>",
                                            "</div>"];
            this.el.append(viewHtml.join(""));
        },
        _init: function () {
            var me = this,
                opts = this.options,
                store = me.options.store;

            me.cachePage = [];
            me.scrollState = {};

            $(".oz-grid-table tr.oz-grid-row", this.el).live("mouseenter", function () {
                $(this).addClass("oz-grid-row-over");
            }).live("mouseleave", function () {
                $(this).removeClass("oz-grid-row-over");
            }).live("click", function () {
                $(".oz-grid-table tr.oz-grid-row", this.el).removeClass("oz-grid-row-selected");
                $(this).toggleClass("oz-grid-row-selected");
                var data = $(this).data();
                me._trigger("rowclick", null, [data.record, data.rowidx]);
            }).live("dblclick", function () {
                var data = $(this).data();
                me._trigger("rowdblclick", null, [data.record, data.rowidx]);
            });

            $(".oz-grid-table tr.oz-grid-row .oz-grid-cell-inner:has(.oz-grid-checkbox)", this.el).live("click", function () {
                $(this).closest(".oz-grid-row").toggleClass("oz-grid-row-selected");
                return false;
            })

            //绑定数据字段
            store.addEvent({
                "beforeload": function () {
                    me.mask();
                },
                "datachange": function (event, data) {
                    me.show();
                }
            });
        },
        mask: function () {
            this.showing = true;
        },
        unmask: function () {
            this.showing = false;
        },
        setsize: function (w, h) {
            this.base(w, h);
            //设置视图底部的便宜
        },
        show: function () {
            this.mask();
            var me = this,
                opts = this.options,
                columns = opts.columns,
                store = opts.store,
                incache = false;
            var data = store.getPage();
            var currentPage = store.currentPage;
            try {
                var pageTable = this.getTable();
                pageTable.addClass("oz-page-num-" + currentPage);
                this._trigger("beforeShow");

                if (this.dataAppend === true) {
                    //验证是否已经在显示的荤菜中
                    for (var i = 0; i < me.cachePage.length; i++) {
                        if (me.cachePage[i] === currentPage) {
                            incache = true;
                            break;
                        }
                    }
                    if (!incache) {
                        var removePage = -1;
                        if (me.cachePage.length === 0 || (currentPage - 1) === me.cachePage[me.cachePage.length - 1]) {
                            //appendAfter
                            me.cachePage.push(currentPage);
                            if (me.cachePage.length > opts.cacheSize) {
                                removePage = me.cachePage.shift();
                                this.el.find(".oz-grid-table-ct").find(".oz-page-num-" + removePage).remove();
                                this.el.scrollTop(this.el.scrollTop());
                            }
                            this.el.find(".oz-grid-table-ct .oz-grid-table-foot").before(pageTable);
                        } else if ((currentPage + 1) === me.cachePage[0]) {
                            //insertBefore
                            me.cachePage.unshift(currentPage);
                            if (me.cachePage.length > opts.cacheSize) {
                                removePage = me.cachePage.pop();
                                this.el.find(".oz-grid-table-ct").find(".oz-page-num-" + removePage).remove();
                            }
                            this.el.find(".oz-grid-table-ct .oz-grid-table-head").after(pageTable);
                            if (removePage > 0) {
                                this.el.scrollTop(pageTable.height());
                            }
                        }
                    }
                } else {
                    this.dataAppend = true;
                    this.el.scrollTop(0);
                    this.el.find(".oz-grid-table-ct .oz-grid-table").remove();
                    me.cachePage = [currentPage];
                    this.el.find(".oz-grid-table-ct .oz-grid-table-head").after(pageTable);
                }
                this._trigger("afterShow");
                this.layout();
                //IE下在隐藏的时候，对高度的算法会有问题。
                //this.el.trigger("resize");
                this.dataAppend = false;
                me.unmask();
            } catch (e) {
                alert(e)
            }

        },
        getTable: function () {
            var me = this,
                opts = me.options,
                columns = opts.columns,
                store = opts.store;
            var data = store.getPage();
            var gridheader = this.el.parent().parent().find(":gridheader");
            var width = gridheader.gridheader("getFullWidth");
            var headers = gridheader.gridheader("getHeaders");

            var tableHtml = [];
            //每加载一次，使用一个Table作为容器
            tableHtml.push("<table class='oz-grid-table' style='width:" + width + "px' border='0' cellspacing='0' cellpadding='0'><tbody>");
            //添加一个宽度控制行
            tableHtml.push('<tr>');
            headers.each(function (index) {
                var item = $.data(this, "item");
                tableHtml.push('<th style="height:0px;width:' + ($(this).outerWidth()) + 'px;" class="x-grid-col-resizer-' + ($(this).id()) + '"></th>');
            });
            tableHtml.push('</tr>');
            
            // 添加数据行
            var altLine = opts.altLine;
            var altColor = opts.altColor;
            for (var rowIdx = 0, length = data.length; rowIdx < length; rowIdx++) {
                var record = data[rowIdx];
                if (headers) {
                	if(altLine){
                    	tableHtml.push('<tr class="oz-grid-row ' + (rowIdx % 2 === 0 ? "" : " oz-grid-row-alt") + '" data-rowidx ="' + rowIdx + '"');
                	}else{
                		tableHtml.push('<tr class="oz-grid-row" data-rowidx ="' + rowIdx + '"');
                	}
                	
                    // 判断是否定义了行样式渲染器
                    if(opts.rowStyler){
                    	var rowStyle = opts.rowStyler.call(this, record, rowIdx);
                    	if(null != rowStyle && rowStyle.length > 0)
                    		tableHtml.push(' style="' + rowStyle + '"');
                    }
                    tableHtml.push(' >');
                    
                    opts.count++;
                    $.each(headers, function(colIdx) {
                        var item = $.data(this, "item");
                        var value = "";
                        if(item.dataIndex){
                        	eval("value = (record."+item.dataIndex+")");
                        }
                        
                        var cellValue;
                        if(item.isIdColumn === true){
                        	if(opts.rownumbers === true){
                        		cellValue = "<span>" + (rowIdx + 1) + "</span>";
                        	}else if (item.checkbox === true) {
                                cellValue = "<span class='oz-grid-checkbox'/>";
                            }else if (item.radio === true) {
                                cellValue = "<span class='oz-grid-radio'/>";
                            } else {
                            	cellValue = item.renderer ? item.renderer.call(this, value, record, rowIdx, colIdx, store) : value;
                            }
                        }else{
                        	if (item.checkbox === true) {
                                cellValue = "<span class='oz-grid-checkbox'/>";
                            } else {
                            	cellValue = item.renderer ? item.renderer.call(this, value, record, rowIdx, colIdx, store) : value;
                            }
                        }
                                                
                        tableHtml.push('<td class="oz-grid-cell ' + (colIdx === 0 ? "oz-grid-cell-first " : "") + 'x-grid-cell-' + ($(this).id()) + '" ');
                        if(item.align){
                        	tableHtml.push('align="' + item.align + '" ');
                        }
                        tableHtml.push('>');
                        tableHtml.push('<div class="oz-grid-cell-inner" title="' + (value||"") + '"');
                        
                        // 判断是否定义了样式渲染器
                        if(item.styler){
                        	style = item.styler.call(this, value, record, rowIdx, colIdx, store);
                        	if(null != style && style.length > 0)
                        		tableHtml.push(' style="' + style + '"');
                        }
                        tableHtml.push('>' + (cellValue || '&#160') + '</div>');
                        tableHtml.push('</td>');
                    });
                    tableHtml.push('</tr>');
                }
            }
            tableHtml.push("</tbody></table>");
            var pageTable = $(tableHtml.join(""));

            pageTable.find("tr.oz-grid-row").each(function () {
                var rowIdx = $(this).data("rowidx");
                if (rowIdx > -1) {
                    var record = data[rowIdx];
                    $(this).data("record", record)
                }
            })
            return pageTable;
        },
        _renderRows: function (data) {
            this.data = data;
            if (!data) {
                return;
            }
        },
        headerResize: function (event, column) {
            var me = this;
            me.saveScrollState();
            me.el.find(".oz-grid-table-ct").find(".x-grid-col-resizer-" + column.id()).width(column.outerWidth());
            me.restoreScrollState();
            me.layout();
        },
        saveScrollState: function () {
            var dom = this.dom,
                state = this.scrollState;
            state.left = dom.scrollLeft;
            state.top = dom.scrollTop;
        },
        restoreScrollState: function () {
            var dom = this.dom,
                state = this.scrollState,
                headerEl = this.options.header[0];

            headerEl.scrollLeft = dom.scrollLeft = state.left;
            dom.scrollTop = state.top;
        },
        layout: function () {
            var grid = this.el.parent().parent();
            var width = grid.grid("getGridHeader").gridheader("getFullWidth");
            this.viewWidth = width;
            this.el.find(".oz-grid-table-ct").width(width + (OZ.getScrollBarWidth() + ($.browser.msie ? 1 : 0)));
            this.el.find(".oz-grid-table-ct").find(">table").width(width);
            this._trigger("layout");
        },
        scrollByDelta: function (delta, dir) {
            dir = dir || 'scrollTop';
            var elDom = this.dom;
            elDom[dir] = (elDom[dir] += delta);
        },
        getSelections: function () {
            var ss = $(".oz-grid-table-ct .oz-grid-row-selected");
            return ss.map(function () {
                return $(this).data("record");
            });
        }
    });

    OZ.widget("OZ.grid.Paging", {
        statics: {
            pageTpl: ['<div>',
                                        '<div class="group">',
                                            '<div class="first button" title="转到第一页"><span></span></div>',
                                            '<div class="prev button" title="上一页"><span></span></div>',
                                        '</div>',
                                        '<div class="btnseparator"></div>',
                                        '<div class="group">',
                                            '<span class="pcontrol"> 第 <input type="text" size="2" value="1" />页,共 <span> 1 </span> 页</span>',
                                        '</div> ',
                                        '<div class="btnseparator"></div>',
                                        '<div class="group">',
                                            '<div class="next button" title="下一页"><span></span></div>',
                                            '<div class="last button" title="转到最后一页"><span></span></div>',
                                        '</div>',
                                        '<div class="btnseparator"></div>',
                                        '<div class="group">',
                                            '<div class="reload button" title="刷新"><span></span></div>',
                                        '</div>',
                                        '<div class="btnseparator"></div>',
                                        '<div class="group extendBtns">',
                                        
                                        '</div>',
                                        '<div class="group" style="float:right;">',
                                            '<span class="pageStat"></span>',
                                        '</div>',
                                        '<div style="clear:both"></div>',
                                    '</div>'
                                    ].join(""),
            displayMsg: '显示 {fromRecord} 到 {toRecord} 条,共 {total} 条记录',
            proemsg: '加载数据中.请等待...',
            emptyMsg: "没有内容可显示"
        },
        $type: "gridpaging",
        options: {

        },
        _render: function () {
        	var tpl = OZ.grid.Paging.pageTpl;
            this.el.addClass("oz-grid-pagenav").append(tpl);
            
            if(this.options.extendBtns){
            	var extendBtns = $(".extendBtns");
            	for(i=0; i<this.options.extendBtns.length; i++){
            		var btn = this.options.extendBtns[i];
    				if (btn == '-') {
    					$('<div class="btnseparator"></div>').appendTo(extendBtns);
    				} else {
    					$('<div class="button" title="导出Excel"><span></span></div>').addClass(btn.iconCls || '').click(btn.handler || OZ.noop).appendTo(extendBtns);
    				}
            	}
            }
        },
        _init: function () {
            var me = this,
                jqe = me.el,
                store = me.options.store;
            $('.reload', jqe).click(function () {
                var pageDate = me._getPageData();
                store.loadPage(pageDate.currentPage);
            });
            $('.first', jqe).click(function () {
                store.loadPage(1);
            });
            $('.prev', jqe).click(function () {
                store.previousPage();
            });
            $('.next', jqe).click(function () {
                store.nextPage();
            });
            $('.last', jqe).click(function () {
                var pageDate = me._getPageData();
                store.loadPage(pageDate.pageCount);
            });
            $('.pcontrol input', jqe).keydown($.proxy(this, "_onKeyDown"));

            if ($.browser.msie && $.browser.version < 7) {
                $('.button', jqe).hover(function () {
                    $(this).addClass('btnOver');
                }, function () {
                    $(this).removeClass('btnOver');
                });
            }
            
            store.addEvent({
                "beforeload": function () {
                    me.loading();
                },
                "datachange": function () {
                    me.loaded();
                }
            });
        },
        _onKeyDown: function (e) {
            var me = this,
                jqe = me.el,
                store = me.options.store,
                pageDate = this._getPageData();
            if (e.keyCode == 13) {
                var nv = parseInt($('.pcontrol input', me.el).val());
                if (isNaN(nv)) {
                    $('.pcontrol input', me.el).val(store.currentPage);
                    return;
                } else {
                    nv = Math.min(Math.max(1, nv), pageDate.pageCount);
                    $('.pcontrol input', me.el).val(nv);
                    page = nv;
                }
                store.loadPage(page);
                me._trigger("changePage");
            }
        },
        updateInfo: function () {
            var me = this,
                jqe = me.el,
                store = me.options.store,
                pageDate = this._getPageData();
            $('.pcontrol input', this.pDiv).val(pageDate.currentPage);
            $('.pcontrol span', this.pDiv).html(pageDate.pageCount);
            if (store.totalCount === 0) {
                $('.pageStat', jqe).text(OZ.grid.Paging.emptyMsg);
            } else {
                pageData = this._getPageData();
                $('.pageStat', jqe).text(OZ.String.tpl(OZ.grid.Paging.displayMsg, pageData));
            }
        },
        loading: function () {
            this.options.loading = true;
            $('.reload', this.el).addClass("loading");
            $('.pageStat', this.el).html(OZ.grid.Paging.proemsg);
        },
        loaded: function () {
            this.options.loading = false;
            $('.reload', this.el).removeClass("loading");
            this.updateInfo();
        },
        _getPageData: function () {
            var store = this.options.store,
                totalCount = store.getTotalCount();
            return {
                total: totalCount,
                currentPage: store.currentPage,
                pageCount: Math.ceil(totalCount / store.pageSize),
                //pageCount :  store.getPageCount(),
                fromRecord: ((store.currentPage - 1) * store.pageSize) + 1,
                toRecord: Math.min(store.currentPage * store.pageSize, totalCount)
            };
        }
    });

    /**
     * 视图滚动条对象
     */
    OZ.widget("OZ.grid.Scroller", {
        $type: "scroller",
        options: {
            dock: "top"
        },
        _render: function () {
            var scroller = this,
                scrollBarWidth = OZ.getScrollBarWidth() + ($.browser.msie ? 1 : 0),
                didScroll = false,
                oldScroll = -99999,
                dock = scroller.options.dock;

            scroller.cls = scroller.baseCls + ((dock == "top" || dock == "bottom") ? "-horizontal" : "-vertical");
            scroller.sizePro = (dock == "top" || dock == "bottom") ? "height" : "width";
            scroller.dockCls = "oz-docked-" + scroller.options.dock;
            scroller.el.hide().addClass(this.cls).addClass("oz-docked").addClass(this.dockCls).append("<div class='oz-stretcher'>\u00A0</div>").width(1).height(1)[scroller.sizePro](scrollBarWidth).scroll(function (event) {
                if (!didScroll) {
                    didScroll = true;
                    var b = this;
                    window.setTimeout(function () {
                        scroller._trigger("bodyscroll", event, [b]);
                        didScroll = false;
                    }, 10);
                }
            });
            scroller.stretcher = scroller.el.find(".oz-stretcher");
        },
        scrollTop: function (top) {
            this.el.scrollTop(top);
        },
        scrollLeft: function (left) {
            this.el.scrollLeft(left);
        },
        invalidate: function () {
            var size = this.getSize();
            this.stretcher[this.sizePro](size[this.sizePro]);
            this.dom.scrollTop = this.dom.scrollTop;
        },
        getSize: function () {
            var view = this.options.view,
                width = 1,
                height = 1;
            if (view) {
                if ((dock == "top" || dock == "bottom")) {
                    width = view.find("table").width();
                } else {
                    height = view.find("table").height();
                }
            }
            return {
                width: width,
                height: height
            };
        }
    });

    OZ.widget("OZ.panel.Header", {
        $type: "panelheader",
        _render: function () {
            this.element.append("<span/>")
        },
        setTitle: function (title) {
            this.element.find("span").text(title);
        }
    });

    /**
     * 表格控件
     */
    OZ.widget("OZ.grid.Panel", {
        $type: "grid",
        statics: {
            defaults: {
                errorMessage: '发生错误',
                pageStatMessage: '显示记录从{from}到{to}，总数 {total} 条',
                pageTextMessage: 'Page',
                loadingMessage: '加载中...',
                findTextMessage: '查找',
                noRecordMessage: '没有符合条件的记录存在',
                isContinueByDataChanged: '数据已经改变,如果继续将丢失数据,是否继续?'
            },
            gridtpl: [
                //'<div class="oz-grid">',
                            '<div class="oz-panel-header"/>',
                '<div class="oz-panel-body oz-grid-body"/>',
                //'</div>',
                            ''].join("")
        },
        options: {
            url: null,
            width: 100,
            height: 100,
            colModel: [],
            sortName:"",
            sortOrder:"ASC",
        },
        _parseDomOptions: function () {
            var t = this.el[0];
            return {
                width: (parseInt($.style(t, 'width'), 10) || undefined),
                height: (parseInt($.style(t, 'height'), 10) || undefined),
                left: (parseInt($.style(t, 'left'), 10) || undefined),
                top: (parseInt($.style(t, 'top'), 10) || undefined),
                title: $.attr(t, "title")
            };
        },
        _render: function () {
            var me = this,
                opts = me.options,
                scrollBarWidth = OZ.getScrollBarWidth();

            me.store = new OZ.data.Store({
                pageSize: opts.pageSize || 25,
                currentPage: opts.page,
                proxy: {
                    url: opts.url
                },
                sortname: opts.sortName,
                sortorder: opts.sortOrder
            });
            
            me.store.params = opts.params || [];

            me.container = me.el;
            if (opts.framed) {
                me.container.addClass(me.baseCls + "-default-framed");
            } else {
                me.container.addClass("oz-panel-default");
            }
            me.container.append($.render(OZ.grid.Panel.gridtpl, {}));

            if (opts.title) {
                me.panelheader = me.container.find(".oz-panel-header").panelheader().panelheader("setTitle", opts.title);
            } else {
                me.panelheader = me.container.find(".oz-panel-header").remove();
            }

            me.body = me.container.find(".oz-grid-body").addClass("oz-panel-with-col-lines");

            if(!opts.border){
            	me.container.addClass("oz-panel-noborder");
            }

            me.header = $("<div/>").appendTo(me.container).gridheader({
                columnresize: function (event, data) {
                    me.view.gridview("headerResize", event, data.column);
                },
                sortchange: function (event, column, state, skipClear) {
                    if (state) {
                        var item = $.data(column, "item");
                        if(item){
                        	me.store.sort(item.sortName || item.dataIndex, state,skipClear);
                        }
                    }
                },
                items: opts.columns,
                sortname: opts.sortName,
                sortorder: opts.sortOrder
            });
            
            //TODO 解开分页
            if(opts.pagination){
            	 me.pagenav = $("<div/>").appendTo(me.container);
            	 me.pagenav.gridpaging({
                     store: me.store ,
                     extendBtns: opts.extendBtns
                 });
            }else{
            	me.pagenav = $([]);
            	me.store.pageSize=-1;
            }

            me.view = $("<div/>").appendTo(me.body).gridview({
                layout: function () {
                    me.resizeBody();
                },
                rowclick: opts.rowclick,
                rowdblclick: opts.rowdblclick,
                url: opts.url,
                columns: opts.columns,
                store: me.store,
                header: me.header,
                rownumbers: opts.rownumbers,
                rowStyler: opts.rowStyler,
                altLine: opts.altLine,
                altColor: opts.altColor
            });

            opts.docks = [me.header, me.pagenav];

            me.vb = $("<div/>").appendTo(me.container).scroller({
                dock: "right",
                view: this.view,
                bodyscroll: $.proxy(this, "onVerticalScroll")
            });
            me.hb = $("<div/>").appendTo(me.container).scroller({
                dock: "bottom",
                view: this.view,
                bodyscroll: $.proxy(this, "onHorizontalScroll")
            });

            me.body.mousewheel($.proxy(me, "_bodyMouseSheel"));
        },
        _bodyMouseSheel: function (event, delta, deltaX, deltaY) {
            var me = this;
            var old = me.vb.scrollTop();
            me.vb.scrollTop(me.vb.scrollTop() - delta * 20);
            if (delta > 0) {
                return old === 0;
            } else {
                return me.vb.scrollTop() == old;
            }
        },
        onVerticalScroll: function (event, target) {
            var me = this;
            me.view.scrollTop(target.scrollTop);
        },
        onHorizontalScroll: function (event, target) {
            var me = this;
            me.view.scrollLeft(target.scrollLeft);
            me.header.scrollLeft(target.scrollLeft);
        },
        setSize: function (w, h) {
            var grid = this;
            w && grid.widget().outerWidth(w);
            h && grid.widget().outerHeight(h);

            var view = grid.view,
                body = grid.body,
                widget = grid.widget();
            padding = widget.padding(), border = widget.border();
            width = widget.width(), height = widget.height();

            grid.panelheader.css({
                left: -border.left,
                top: -border.top
            }).outerWidth(w);

            grid.header.css({
                left: padding.left,
                top: grid.panelheader.outerHeight() + padding.top
            }).outerWidth(w);

            grid.body.css({
                left: 0,
                top: grid.panelheader.outerHeight() + grid.header.outerHeight()
            });

            grid.pagenav.css({
                left: padding.left,
                top: h - grid.pagenav.outerHeight()
            }).outerWidth(w);

            this.bodyHeight = h - grid.panelheader.outerHeight() - grid.header.outerHeight() - grid.pagenav.outerHeight() - padding.bottom;
            this.resizeBody();
        },
        resizeBody: function () {
            var grid = this,
                vb = grid.vb,
                hb = grid.hb,
                view = grid.view,
                body = grid.body;

            var bodyHeight = this.bodyHeight,
                bodyWidth = grid.header.outerWidth(),
                scrollWidth = grid.header.gridheader("getFullWidth") - 1,
                scrollHeight = view.find(".oz-grid-table-ct").height(),
                showvb = scrollHeight > bodyHeight,
                showhb = scrollWidth > bodyWidth;

            if (showvb) {
                grid.el.addClass("oz-vertical-scroller-present");
                body.outerWidth(bodyWidth - vb.outerWidth());
                vb.find(".oz-stretcher").height(scrollHeight);
            } else {
                grid.el.removeClass("oz-vertical-scroller-present");
                body.outerWidth(bodyWidth);
            }

            if (showhb) {
                grid.el.addClass("oz-horizontal-scroller-present");
                body.outerHeight(bodyHeight - hb.outerHeight());
                hb.find(".oz-stretcher").width(scrollWidth);
            } else {
                grid.el.removeClass("oz-horizontal-scroller-present");
                body.outerHeight(bodyHeight);
            }
            showvb ? vb.css({
                top: body.position().top,
                left: body.position().left + body.outerWidth()
            }).outerHeight(body.outerHeight()).show() : vb.hide();

            showhb ? hb.css({
                top: body.position().top + body.outerHeight(),
                left: body.position().left
            }).outerWidth(body.outerWidth()).show() : hb.hide();

            //设置滚动调的位置和view的位置一样
            vb[0].scrollTop = view[0].scrollTop;
            hb[0].scrollLeft = view[0].scrollLeft;

            view.gridview("setSize", body.width(), body.height());
        },
        getLhsMarker: function () {
            var me = this;
            if (!me.lhsMarker) {
                me.lhsMarker = $("<div class='oz-grid-resize-marker'/>").appendTo(me.container);
            }
            return me.lhsMarker;
        },
        getRhsMarker: function () {
            var me = this;
            if (!me.rhsMarker) {
                me.rhsMarker = $("<div class='oz-grid-resize-marker'/>").appendTo(me.container);
            }
            return me.rhsMarker;
        },
        getBody: function () {
            var me = this;
            return me.body;
        },
        getGridHeader: function () {
            var me = this;
            return me.header;
        },
        _init: function () {
            var me = this,
                opts = this.options;
            if (opts.fit) {
                this.setSize(this.el.parent().width(), this.el.parent().height());
            } else {
                this.setSizeP(opts.width, opts.height);
            }
            this.store.load();
        },
        reload: function () {
            this.store.load();
        },
        resize: function () {
            var me = this,
                opts = this.options;
            if (opts.fit) {
                this.setSize(this.el.parent().width(), this.el.parent().height());
            } else {
                this.setSizeP(opts.width, opts.height);
            }
        },
        widget: function () {
            return this.container;
        },
        getSelections: function () {
            return this.view.gridview("getSelections");
        },
        setSizeP:function(width,height){
            var widthStr = width,
                heightStr = height;
            if (widthStr.substr(widthStr.length-1,widthStr.length)=="%"){
                widthStr = this.el.parent().width()*parseFloat(widthStr.substring(0,widthStr.length-1))/100;
            }
            if (heightStr.substr(heightStr.length-1,heightStr.length)=="%"){
                heightStr = this.el.parent().height()*parseFloat(heightStr.substring(0,heightStr.length-1))/100;
            }
            this.setSize(Number(widthStr), Number(heightStr));
        }
    });
})(jQuery);
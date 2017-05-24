<!-- hi IE,please go to Quirks Mode-->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page contentType="text/html;charset=UTF-8"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>一个高宽自适用100%,又有部分高宽固定的例子</title>
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
<link rel="stylesheet" type="text/css" href="layout.css" />
</head>
<body>
	<div id="header">
		<div id="innerHeader">
			<h3>本实例是，高度自适应100%显示，顶部和底部固定，中间自适应。左侧固定，右侧自适应的实例。</h3>
		</div>
	</div>

	<div id="sortList">
		<div class="inner">
			<ul>
				<li class="folder"><a href="#">显示文件夹</a>
				</li>
				<li class="tags"><a href="#">显示标签</a>
				</li>
			</ul>
		</div>
	</div>
	<div id="selector">
		<div class="inner">
			<h3>您的标签</h3>
			<p>
				<a href="http://www.websjy.com/html/">首页</a> <a
					href="http://www.websjy.com/html/html/news.html">设计资讯</a> <a
					href="http://www.websjy.com/html/html/bbs.html">论坛精选</a> <a
					href="http://www.websjy.com/html/html/uchblog.html">设计日志</a> <a
					href="http://www.websjy.com/html/html/uchimage.html">设计图片</a> <a
					href="http://www.websjy.com/html/m.php?name=jc">设计教程</a> <a
					href="http://www.websjy.com/html/m.php?name=sc">设计素材</a> <a
					href="http://www.websjy.com/my/">设计部落</a> <a
					href="http://www.websjy.com/bbs">设计论坛</a>
			</p>
			test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test
		</div>
	</div>


	<div id="xbar"></div>

	<div id="tools">
		<div class="inner">这里可以当工具栏</div>
	</div>
	<div id="status">
		<div class="inner">这里可以显示状态 ^^</div>
	</div>
	<div id="gird">
		<div class="inner">
			<p>本来是以前一个朋友要做收藏夹让我抄的,live的方式不错...只在一屏显示全部内容,部分内容要固定高宽,所以用了比较垃圾的方式...比如把IE骗进乱七八糟木模式(Quirks
				Mode)。</p>
			<p>
				所有主布局的元素都是用position:absolute流出来body后..根据不同浏览器写不同的定位方式 <br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test<br />test
			</p>
		</div>
	</div>
	<div id="pages">
		<div class="inner">
			<a href="#"><img
				src="http://labs.aoao.org.cn/demo/layout/100x100/images/f.gif" />
			</a> <a href="#"><img
				src="http://labs.aoao.org.cn/demo/layout/100x100/images/p.gif" />
			</a> <span>1/1 页</span> <a href="#"><img
				src="http://labs.aoao.org.cn/demo/layout/100x100/images/n.gif" />
			</a> <a href="#"><img
				src="http://labs.aoao.org.cn/demo/layout/100x100/images/e.gif" />
			</a>
		</div>
	</div>
	<div id="footer">
		<div id="innerFooter">
			<p id="copyright">
				Copyright ? <a rel="me" href="http://www.websjy.com/">aoao</a> .
				Some rights reserved</a>.
			</p>
		</div>
	</div>
</body>
</html>
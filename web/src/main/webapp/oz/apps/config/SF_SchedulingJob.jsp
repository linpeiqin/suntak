<%@ page contentType="text/html;charset=UTF-8"%>
<style>
	.Scheduling-title{ font-weight:bold;}
	.Scheduling-tableWrap {border-top:1px solid #CCCCCC;border-left:1px solid #CCCCCC; table-layout:inherit;}
	.Scheduling-tableWrap td{ border-bottom:1px solid #CCCCCC;border-right:1px solid #CCCCCC; padding:3px; overflow:auto;}
	.Scheduling-tableWrap .top td{ background-color:#DAF0FC;border-top:1px solid #CCCCCC;border-left:1px solid #CCCCCC; color:#004A80;}
	.Scheduling-tableWrap .grayBg td{ background-color:#F0F2F3; }
	.Scheduling-explain .first{ color:#FF0000; text-align:center;}
	.Scheduling-explain .colorRed{ color:#FF0000;}
	.Scheduling-explain .coloGray{ color:#707070;}
</style>
<div class="post">
	<br/>
	<br/>
	<span class="Scheduling-title">
		&nbsp;&nbsp;1、定时表达式配置格式：
	</span>
	[秒] [分] [小时] [日] [月] [周] [年]
	<br/>
	<table class="Scheduling-tableWrap"  width="100%" border="0" cellpadding="2" cellspacing="0" >
		<tr class="top">
			<td width="30">&nbsp;序号</td>
			<td width="60">&nbsp;说明</td>
			<td width="80">&nbsp;是否必填</td>
			<td width="150">&nbsp;允许填写的值</td>
			<td>&nbsp;允许的通配符 </td>
		</tr>
       	<tr>
       		<td style="text-align: center;font-weight: bold;">&nbsp;1</td>
           	<td>&nbsp;秒</td>
           	<td>&nbsp;是</td>
           	<td>&nbsp;0-59&nbsp; </td>
           	<td>&nbsp;, - * /</td>
       	</tr>
		<tr class="grayBg">
			<td style="text-align: center;font-weight: bold;">&nbsp;2</td>
			<td>&nbsp;分</td>
			<td>&nbsp;是</td>
			<td>&nbsp;0-59</td>
			<td>&nbsp;, - * /</td>
		</tr>
		<tr valign="middle" align="left">
			<td style="text-align: center;font-weight: bold;">&nbsp;3</td>
			<td>&nbsp;小时</td>
			<td>&nbsp;是</td>
			<td>&nbsp;0-23</td>
			<td>&nbsp;, - * /</td>
		</tr>
		<tr class="grayBg" valign="middle" align="left">
			<td style="text-align: center;font-weight: bold;">&nbsp;4</td>
			<td>&nbsp;日</td>
			<td>&nbsp;是</td>
			<td>&nbsp;1-31</td>
			<td>&nbsp; , - * ? / L W</td>
		</tr>
		<tr valign="middle" align="left">
			<td style="text-align: center;font-weight: bold;">&nbsp;5</td>
			<td>&nbsp;月</td>
			<td>&nbsp;是</td>
			<td>&nbsp;1-12 or JAN-DEC</td>
			<td>&nbsp;, - * /</td>
		</tr>
		<tr class="grayBg" valign="middle" align="left">
			<td style="text-align: center;font-weight: bold;">&nbsp;6</td>
			<td>&nbsp;周</td>
			<td>&nbsp;是</td>
			<td>&nbsp;1-7 or SUN-SAT</td>
			<td>&nbsp;, - * ? / L # </td>
		</tr>
		<tr>
			<td style="text-align: center;font-weight: bold;">&nbsp;7</td>
			<td>&nbsp;年</td>
			<td>&nbsp;否</td>
			<td>&nbsp;empty 或 1970-2099</td>
			<td>&nbsp;, - * / </td>
		</tr>
	</table>
	<br/><br/>
	<span class="Scheduling-title">&nbsp;&nbsp;2、通配符说明:</span>
	<br/>
	<table class="Scheduling-tableWrap Scheduling-explain" width="100%" border="0" cellspacing="0" cellpadding="0">
 			<tr class="top">
   			<td width="50">
   				符号
   			</td>
   			<td width="200">
   				作用
   			</td>
   			<td>
   				用法
   			</td>
 			</tr>
 			<tr>
   			<td class="first" style="font-weight: bold;">*</td>
   			<td style="vertical-align: top;">
   				表示所有值
   			</td>
   			<td style="vertical-align: top;">
   				例如：在分的字段上设置 &quot;<span class="colorRed">*</span>&quot;,表示每一分钟都会触发。
   			</td>
 			</tr>
 			<tr>
   			<td class="first" style="font-weight: bold;">?</td>
   			<td style="vertical-align: top;">
   				表示不指定值，使用的场景为不需要关心当前设置这个字段的值
   			</td>
   			<td style="vertical-align: top;">
   				例如：要在每月的10号触发一个操作，但不关心是周几，所以需要周位置的那个字段设置为&quot;?&quot; <br/>
   				具体设置为:<b> 0 0 0 10 <span class="colorRed">*</span> ? </b><br/>
   			</td>
 			</tr>
 			<tr>
   			<td class="first" style="font-weight: bold;">-</td>
   			<td style="vertical-align: top;">
   				表示区间
   			</td>
   			<td style="vertical-align: top;">
   				例如：在小时上设置 &quot;10-12&quot;,表示 10,11,12点都会触发。
   			</td>
 			</tr>
 			<tr>
   			<td class="first" style="font-weight: bold;">,</td>
   			<td style="vertical-align: top;">
   				表示指定多个值
   			</td>
   			<td style="vertical-align: top;">
   				例如：在周字段上设置 &quot;MON,WED,FRI&quot; 表示周一，周三和周五触发。
   			</td>
 			</tr>
 			<tr>
   			<td class="first" style="font-weight: bold;">/</td>
   			<td style="vertical-align: top;">
   				用于递增触发
   			</td>
   			<td style="vertical-align: top;">
   				例如：在秒上面设置&quot;5/15&quot; 表示从5秒开始，每增15秒触发(5,20,35,50)。 在月字段上设置'1/3'所示每月1号开始，每隔三天触发一次。
   			</td>
 			</tr>
 			<tr>
   			<td class="first" style="font-weight: bold;">L</td>
   			<td style="vertical-align: top;">
   				表示最后的意思
   			</td>
   			<td style="vertical-align: top;">
   				在日字段设置上，表示当月的最后一天(依据当前月份，如果是二月还会依据是否是润年[leap]), 在周字段上表示星期六，相当于&quot;7&quot;或&quot;SAT&quot;。如果在&quot;L&quot;前加上数字，则表示该数据的最后一个。<br/>
     			例如：在周字段上设置&quot;6L&quot;这样的格式,则表示“本月最后一个星期五&quot; 
     		</td>
 			</tr>
 			<tr>
   			<td class="first" style="font-weight: bold;">W</td>
   			<td style="vertical-align: top;">
   				表示离指定日期的最近那个工作日(周一至周五)
   			</td>
   			<td style="vertical-align: top;">
   				例如：在日字段上设置&quot;15W&quot;，表示离每月15号最近的那个工作日触发。如果15号正好是周六，则找最近的周五(14号)触发, 如果15号是周未，则找最近的下周一(16号)触发.如果15号正好在工作日(周一至周五)，则就在该天触发。如果指定格式为 &quot;1W&quot;,它则表示每月1号往后最近的工作日触发。如果1号正是周六，则将在3号下周一触发。(注，&quot;W&quot;前只能设置具体的数字,不允许区间&quot;-&quot;)。<br/><br/>
				<span class="coloGray">小提示： 'L'和 'W'可以一组合使用。如果在日字段上设置&quot;LW&quot;,则表示在本月的最后一个工作日触发。 </span>
			</td>
 			</tr>
 			<tr>
   			<td class="first" style="font-weight: bold;">#</td>
   			<td style="vertical-align: top;">
   				序号(表示每月的第几个周几)
   			</td>
   			<td style="vertical-align: top;">
   				例如：在周字段上设置&quot;6#3&quot;表示在每月的第三个周六.注意如果指定&quot;#5&quot;,正好第五周没有周六，则不会触发该配置(用在母亲节和父亲节再合适不过了)。 <br/><br/>
   				<span class="coloGray">小提示： 周字段的设置，若使用英文字母是不区分大小写的 MON 与mon相同。</span>
   			</td>
 		</tr>
	</table>
	<br/><br/>
	<span class="Scheduling-title">&nbsp;&nbsp;3、常用示例:</span><br />
	<table width="100%" border="0" cellpadding="0" cellspacing="0"  class="Scheduling-tableWrap">
		<tbody>
			<tr>
				<td width="200" class="confluenceTd" style="font-weight: bold;"><tt>0 0 12 * * ?</tt> </td>
				<td class="confluenceTd"> 每天12点触发</td>
			</tr>
			<tr class="grayBg">
				<td class="confluenceTd" style="font-weight: bold;"> <tt>0 15 10 ? * *</tt> </td>
				<td class="confluenceTd"> 每天10点15分触发</td>
			</tr>
			<tr>
				<td class="confluenceTd" style="font-weight: bold;"> <tt>0 15 10 * * ?</tt> </td>
				<td class="confluenceTd"> 每天10点15分触发 </td>
			</tr>
			<tr class="grayBg">
				<td class="confluenceTd" style="font-weight: bold;"> <tt>0 15 10 * * ? *</tt> </td>
				<td class="confluenceTd"> 每天10点15分触发 </td>
			</tr>
			<tr>
				<td class="confluenceTd" style="font-weight: bold;"> <tt>0 15 10 * * ? 2005</tt> </td>
				<td class="confluenceTd"> 2005年每天10点15分触发</td>
			</tr>
			<tr class="grayBg">
				<td class="confluenceTd" style="font-weight: bold;"> <tt>0 * 14 * * ?</tt> </td>
				<td class="confluenceTd"> 每天下午的 2点到2点59分每分触发</td>
			</tr>
			<tr>
				<td class="confluenceTd" style="font-weight: bold;"> <tt>0 0/5 14 * * ?</tt> </td>
				<td class="confluenceTd"> 每天下午的 2点到2点59分(整点开始，每隔5分触发) </td>
			</tr>
			<tr class="grayBg">
				<td class="confluenceTd" style="font-weight: bold;"><tt>0 0/5 14,18 * * ?</tt> </td>
				<td class="confluenceTd"> 
					每天下午的 2点到2点59分(整点开始，每隔5分触发)<br/>
					每天下午的 18点到18点59分(整点开始，每隔5分触发)<br/>
				</td>
			</tr>
			<tr>
				<td class="confluenceTd" style="font-weight: bold;"> <tt>0 0-5 14 * * ?</tt> </td>
				<td class="confluenceTd"> 每天下午的 2点到2点05分每分触发</td>
			</tr>
			<tr class="grayBg">
				<td class="confluenceTd" style="font-weight: bold;"> <tt>0 10,44 14 ? 3 WED</tt> </td>
				<td class="confluenceTd"> 3月分每周三下午的 2点10分和2点44分触发</td>
			</tr>
			<tr>
				<td class="confluenceTd" style="font-weight: bold;"> <tt>0 15 10 ? * MON-FRI</tt> </td>
				<td class="confluenceTd"> 从周一到周五每天上午的10点15分触发</td>
			</tr>
			<tr class="grayBg">
				<td class="confluenceTd" style="font-weight: bold;"> <tt>0 15 10 15 * ?</tt> </td>
				<td class="confluenceTd"> 每月15号上午10点15分触发</td>
			</tr>
			<tr>
				<td class="confluenceTd" style="font-weight: bold;"> <tt>0 15 10 L * ?</tt> </td>
				<td class="confluenceTd"> 每月最后一天的10点15分触发</td>
			</tr>
			<tr class="grayBg">
				<td class="confluenceTd" style="font-weight: bold;"> <tt>0 15 10 ? * 6L</tt> </td>
				<td class="confluenceTd"> 每月最后一周的星期五的10点15分触发</td>
			</tr>
			<tr>
				<td class="confluenceTd" style="font-weight: bold;"> <tt>0 15 10 ? * 6L 2002-2005</tt> </td>
				<td class="confluenceTd"> 从2002年到2005年每月最后一周的星期五的10点15分触发</td>
			</tr>
			<tr class="grayBg">
				<td class="confluenceTd" style="font-weight: bold;"> <tt>0 15 10 ? * 6#3</tt> </td>
				<td class="confluenceTd"> 每月的第三周的星期五开始触发</td>
			</tr>
			<tr>
				<td class="confluenceTd" style="font-weight: bold;"> <tt>0 0 12 1/5 * ?</tt> </td>
				<td class="confluenceTd"> 每月的第一个中午开始每隔5天触发一次</td>
			</tr>
			<tr class="grayBg">
				<td class="confluenceTd" style="font-weight: bold;"> <tt>0 11 11 11 11 ?</tt> </td>
				<td class="confluenceTd"> 每年的11月11号 11点11分触发</td>
			</tr>
		</tbody>
	</table>
</div>					
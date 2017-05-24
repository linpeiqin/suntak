<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/oz/includes/taglibs.jsp"%>
   <div id="page-top" class="oz-page-top">
		<oz:toolbar action="ems/maintainContentAction">
			<oz:tbSeperator />
			<oz:tbButton id="addData"  icon="oz-icon oz-icon-0928" text="添加"  onclick="addNew()" />
			<oz:tbSeperator />
			<oz:tbButton id="deleteData"  icon="oz-icon oz-icon-0927" text="删除"  onclick="deletedata()" />
		</oz:toolbar>
	</div>
	<div id="test" style="overflow-x:hidden;overflow-y:scroll;height: 320px;">
		<table class="oz-form-bordertable"  width="100%">
			<tr class="oz-form-tr"  >
				<td class="oz-form-label-l" width="5%"></td>
					
				<td class="oz-form-label-l" width="35%" style="text-align:center">保养内容</td>
					
				<td class="oz-form-label-l" width="60%">
					<table width="100%">
					 <tr>
					 <td class="oz-form-label-l" colspan="6" style="text-align:center">处理方法</td>
					 <tr>
					 <tr class="oz-form-label-l">
					 <td class="oz-form-label-l" style="text-align:center"> 检查 </td>
					 <td class="oz-form-label-l" style="text-align:center"> 清洁</td>
					 <td class="oz-form-label-l" style="text-align:center"> 调整</td>
					 <td class="oz-form-label-l" style="text-align:center"> 润滑</td>
					 <td class="oz-form-label-l" style="text-align:center"> 修理</td>
					 <td class="oz-form-label-l" style="text-align:center"> 更换</td>
					</table>
					</td>
			</tr>
			</table>
			
		<table  class="oz-form-bordertable"  id="maintainContentGrid" width="100%" >
		<c:if test="${empty bean }">
			<tr>
						<td class="oz-property" width="5%"><input type="checkbox" name="selectedBox" /></td>
						<td class="oz-property" width="35%"><input type="text" name="content"  /></td>
					    <td class="oz-property" width="10%"><input type="checkbox" name="mCheck_0" value="1" /></td>
					    <td class="oz-property" width="10%"><input type="checkbox" name="mClear_0" value="1" /></td>
					    <td class="oz-property" width="10%"><input type="checkbox" name="mAdjust_0" value="1" /></td>
						<td class="oz-property" width="10%"><input type="checkbox" name="mLubric_0" value="1" /></td>
						<td class="oz-property" width="10%"><input type="checkbox" name="mRepair_0" value="1" /></td>
						<td class="oz-property" width="10%"><input type="checkbox" name="mChange_0" value="1" /></td>
					</tr>
		</c:if>
		<c:if test="${!empty bean }">
			<c:forEach items="${bean.maintainContents }" var="it" varStatus="vstatus">
					<tr>
						<td class="oz-property" width="5%"><input type="checkbox" name="selectedBox" /></td>
						<td class="oz-property" width="35%"><input type="text" name="content" value="${it.content }"  /></td>
					    <td class="oz-property" width="10%"><input type="checkbox" name="mCheck_${vstatus.index }" ${it.mCheck eq '1'?'checked':'' } value="1" /></td>
					    <td class="oz-property" width="10%"><input type="checkbox" name="mClear_${vstatus.index }" ${it.mClear eq '1'?'checked':'' } value="1" /></td>
					    <td class="oz-property" width="10%"><input type="checkbox" name="mAdjust_${vstatus.index }" ${it.mAdjust eq '1'?'checked':'' } value="1" /></td>
						<td class="oz-property" width="10%"><input type="checkbox" name="mLubric_${vstatus.index }" ${it.mLubric eq '1'?'checked':'' } value="1" /></td>
						<td class="oz-property" width="10%"><input type="checkbox" name="mRepair_${vstatus.index }" ${it.mRepair eq '1'?'checked':'' } value="1" /></td>
						<td class="oz-property" width="10%"><input type="checkbox" name="mChange_${vstatus.index }" ${it.mChange eq '1'?'checked':'' } value="1" /></td>
					</tr>
				</c:forEach>
			</c:if>
			</table>
		</div>	
<oz:js jsSrc="/ems/equipmentrepair/js/ems.maintaincontent.FE.js" />



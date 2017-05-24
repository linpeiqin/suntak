/*===================================================== 数据导入编写说明 =================================================================*/
-- 1、在每一个数据插入前面描述该数据说明；
-- 2、如果该数据是测试数据，而非系统必须数据，则必须在数据导入说明前使用：/* TESTDATA */
/*===================================================== 数据导入编写说明 =================================================================*/

-- 插入门户首页布局数据			   
INSERT INTO OZ_PORTAL_HOMEPAGE_LAYOUT(ID,NAME, STATUS, ICON_CLAZZ, HTML_DOM) 
							   VALUES(HIBERNATE_SEQUENCE.NEXTVAL,'布局1', 0, 'oz-icon-layout-2', '<table class="columns" cellspacing="2" border="0" cellpadding="0">
    <tr class="minHeight">
        <td id="regionLeft" class="layoutRegion"></td>
        <td style="width:2px;"></td>
        <td id="regionRight" class="layoutRegion" style="width:30%;"></td>
    </tr>
</table>');

INSERT INTO OZ_PORTAL_HOMEPAGE_LAYOUT(ID,NAME, STATUS, ICON_CLAZZ, HTML_DOM) 
							   VALUES(HIBERNATE_SEQUENCE.NEXTVAL,'布局2', 0, 'oz-icon-layout-3', '<table class="columns" cellspacing="2" border="0" cellpadding="0">
    <tr class="minHeight">
        <td id="regionLeft" class="layoutRegion" style="width:24%;"></td>
        <td style="width:2px;"></td>
        <td id="regionCenter" class="layoutRegion"></td>
        <td style="width:2px;"></td>
        <td id="regionRight" class="layoutRegion" style="width:24%;"></td>
    </tr>
</table>');	

INSERT INTO OZ_PORTAL_HOMEPAGE_LAYOUT(ID,NAME, STATUS, ICON_CLAZZ, HTML_DOM) 
							   VALUES(HIBERNATE_SEQUENCE.NEXTVAL,'布局3', 0, 'oz-icon-layout-4', '<table class="columns" cellspacing="2" border="0" cellpadding="0">
    <tr class="minHeight">
        <td id="regionLeft" class="layoutRegion""></td>
        <td style="width:2px;"></td>
        <td id="regionCenter" class="layoutRegion"></td>
        <td style="width:2px;"></td>
        <td id="regionRight" class="layoutRegion" style="width:24%;"></td>
    </tr>
</table>');	

INSERT INTO OZ_PORTAL_HOMEPAGE_LAYOUT(ID,NAME, STATUS, ICON_CLAZZ, HTML_DOM) 
							   VALUES(HIBERNATE_SEQUENCE.NEXTVAL,'布局4', 0, 'oz-icon-layout-6', '<table class="columns" cellspacing="2" border="0" cellpadding="0">
    <tr>
        <td>
            <table class="columns" cellspacing="0" border="0" cellpadding="0">
                <tr class="minHeight">
                    <td id="regionTopLeft" class="layoutRegion" style="width:50%;"></td>
                    <td style="width:2px;"></td>
                    <td id="regionTopRight" class="layoutRegion"></td>
                </tr>
                <tr height="2px">
                    <td colspan="3"></td>
                </tr>
                <tr class="minHeight">
                    <td id="regionBottom" class="layoutRegion" colspan="3"></td>
                </tr>
            </table>
        </td>
        <td style="width:2px;"></td> 
        <td id="regionRight" class="layoutRegion" style="width:243px;_width:236px;"></td>
    </tr>
</table>');	

INSERT INTO OZ_PORTAL_HOMEPAGE_LAYOUT(ID,NAME, STATUS, ICON_CLAZZ, HTML_DOM) 
							   VALUES(HIBERNATE_SEQUENCE.NEXTVAL,'布局5', 0, 'oz-icon-layout-7', '<table class="columns" cellspacing="2" border="0" cellpadding="0">
    		<tr>
        		<td>
            		<table class="columns" cellspacing="0" border="0" cellpadding="0">
                		<tr class="minHeight">
                    		<td id="regionTop" class="layoutRegion" style="width:50%;"></td>
                		</tr>
                		<tr height="2px">
                    		<td></td>
                		</tr>
                		<tr class="minHeight">
                			<td>
                    			<table class="columns" cellspacing="0" border="0" cellpadding="0">
                    				<tr>
                    					<td id="regionBottomLeft" class="layoutRegion" style="width:50%;"></td>
                    					<td style="width:2px;"></td>
                    					<td id="regionBottomRight" class="layoutRegion"></td>
                    				</tr>
                    			</table>
                    		</td>
                		</tr>
            		</table>
        		</td>
        		<td style="width:2px;"></td> 
        		<td id="regionRight" class="layoutRegion" style="width:243px;_width:236px;"></td>
    		</tr>
		</table>');	

INSERT INTO OZ_PORTAL_HOMEPAGE_LAYOUT(ID,NAME, STATUS, ICON_CLAZZ, HTML_DOM) 
							   VALUES(HIBERNATE_SEQUENCE.NEXTVAL,'布局6', 0, 'oz-icon-layout-8', '<table class="columns" cellspacing="2" border="0" cellpadding="0">
    		<tr>
        		<td>
            		<table class="columns" cellspacing="0" border="0" cellpadding="0">
                		<tr class="minHeight">
                			<td>
                    			<table class="columns" cellspacing="0" border="0" cellpadding="0">
                    				<tr>
                    					<td id="regionTopLeft" class="layoutRegion" style="width:50%;"></td>
                    					<td style="width:2px;"></td>
                    					<td id="regionTopRight" class="layoutRegion"></td>
                    				</tr>
                    			</table>
                    		</td>
                		</tr>
                		<tr height="2px">
                    		<td></td>
                		</tr>
                		<tr class="minHeight">
                    		<td id="regionCenter" class="layoutRegion" style="width:50%;"></td>
                		</tr>
                		<tr height="2px">
                    		<td></td>
                		</tr>
                		<tr class="minHeight">
                			<td>
                    			<table class="columns" cellspacing="0" border="0" cellpadding="0">
                    				<tr>
                    					<td id="regionBottomLeft" class="layoutRegion" style="width:50%;"></td>
                    					<td style="width:2px;"></td>
                    					<td id="regionBottomRight" class="layoutRegion"></td>
                    				</tr>
                    			</table>
                    		</td>
                		</tr>
            		</table>
        		</td>
        		<td style="width:2px;"></td> 
        		<td id="regionRight" class="layoutRegion" style="width:243px;_width:236px;"></td>
    		</tr>
		</table>');			


-- 插入门户首页中可选模块数据
INSERT INTO OZ_PORTAL_PORTLET (ID,NAME, CODE, STATUS, URL_PATH, ICON, MAX_WINDOW, MIN_WINDOW, HREF_MORE)
						VALUES(HIBERNATE_SEQUENCE.NEXTVAL,'首页小部件', 'HomePagePortlet', 0, '/module/portalAction.do?action=portlet', 'oz-icon-0215', 'Y', 'Y', '');

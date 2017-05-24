/*===================================================== 数据导入编写说明 =================================================================*/
-- 1、在每一个数据插入前面描述该数据说明；
-- 2、如果该数据是测试数据，而非系统必须数据，则必须在数据导入说明前使用：/* TESTDATA */
/*===================================================== 数据导入编写说明 =================================================================*/
   
-- 插入权限配置数据.系统管理
INSERT INTO OZ_SEC_PERMISSIONS(ID,TYPE, STATUS, INNER_FLAG, NAME, CODE, ORDER_NO, URL_PATH, CSS_CLASS, DESCRIPTION) 
	                    VALUES(HIBERNATE_SEQUENCE.NEXTVAL,0, 0, 'Y', 'oz.permission.systemmgm', 'PID_MK_XTGL', '99', '', 'oz-permission-xtgl', '');
INSERT INTO OZ_SEC_PERMISSIONS(ID,PARENT_ID, TYPE, STATUS, INNER_FLAG, NAME, CODE, ORDER_NO, URL_PATH, CSS_CLASS, DESCRIPTION)
	   SELECT HIBERNATE_SEQUENCE.NEXTVAL,p.id, 0, 0, 'Y', 'oz.permission.userlog.userlog', 'PID_USERLOG_YHRZ', p.ORDER_NO+'99', '/component/userLogAction.do?action=display', 'oz-permission-userlog-yhrz', ''
       FROM OZ_SEC_PERMISSIONS p
       WHERE p.CODE = 'PID_MK_XTGL';	   	   
INSERT INTO OZ_SEC_PERMISSIONS(ID,PARENT_ID, TYPE, STATUS, INNER_FLAG, NAME, CODE, ORDER_NO, URL_PATH, CSS_CLASS, DESCRIPTION)
	   SELECT HIBERNATE_SEQUENCE.NEXTVAL,p.id, 1, 0, 'Y', 'oz.permission.systemmgm.administrator', 'PID_SYSTEM_ADMINISTRATOR', p.ORDER_NO+'99', '', '', ''
       FROM OZ_SEC_PERMISSIONS p
       WHERE p.CODE = 'PID_MK_XTGL';

-- 插入权限配置数据.系统管理.权限管理
INSERT INTO OZ_SEC_PERMISSIONS(ID,PARENT_ID, TYPE, STATUS, INNER_FLAG, NAME, CODE, ORDER_NO, URL_PATH, CSS_CLASS, DESCRIPTION)
	   SELECT HIBERNATE_SEQUENCE.NEXTVAL,p.id, 0, 0, 'Y', 'oz.permission.security.quanxianguanli', 'PID_SECURITY_QXGL', p.ORDER_NO+'10', '', 'oz-permission-security-qxgl', ''
	   FROM OZ_SEC_PERMISSIONS p
       WHERE p.CODE = 'PID_MK_XTGL';
INSERT INTO OZ_SEC_PERMISSIONS(ID,PARENT_ID, TYPE, STATUS, INNER_FLAG, NAME, CODE, ORDER_NO, URL_PATH, CSS_CLASS, DESCRIPTION)
	   SELECT HIBERNATE_SEQUENCE.NEXTVAL,p.id, 0, 0, 'Y', 'oz.permission.security.quanxianpeizhi', 'PID_SECURITY_QXPZ', p.ORDER_NO+'10', '/security/permissionAction.do?action=display', 'oz-permission-security-qxpz', ''
	   FROM OZ_SEC_PERMISSIONS p
       WHERE p.CODE = 'PID_SECURITY_QXGL';
INSERT INTO OZ_SEC_PERMISSIONS(ID,PARENT_ID, TYPE, STATUS, INNER_FLAG, NAME, CODE, ORDER_NO, URL_PATH, CSS_CLASS, DESCRIPTION)
	   SELECT HIBERNATE_SEQUENCE.NEXTVAL,p.id, 0, 0, 'Y', 'oz.permission.security.shujuquanxianguanli', 'PID_SECURITY_SJQXGL', p.ORDER_NO+'20', '/acl/dataScopePermissionAction.do?action=display', 'oz-permission-security-sjqxgl', ''
	   FROM OZ_SEC_PERMISSIONS p
       WHERE p.CODE = 'PID_SECURITY_QXGL';
INSERT INTO OZ_SEC_PERMISSIONS(ID,PARENT_ID, TYPE, STATUS, INNER_FLAG, NAME, CODE, ORDER_NO, URL_PATH, CSS_CLASS, DESCRIPTION)
	   SELECT HIBERNATE_SEQUENCE.NEXTVAL,p.id, 0, 0, 'Y', 'oz.permission.security.yewuquanxianguanli', 'PID_SECURITY_YWQXGL', p.ORDER_NO+'30', '/acl/functionPermissionAction.do?action=display', 'oz-permission-security-ywqxgl', ''
	   FROM OZ_SEC_PERMISSIONS p
       WHERE p.CODE = 'PID_SECURITY_QXGL';       
INSERT INTO OZ_SEC_PERMISSIONS(ID,PARENT_ID, TYPE, STATUS, INNER_FLAG, NAME, CODE, ORDER_NO, URL_PATH, CSS_CLASS, DESCRIPTION)
	   SELECT HIBERNATE_SEQUENCE.NEXTVAL,p.id, 0, 0, 'Y', 'oz.permission.security.jueseguangli', 'PID_SECURITY_JSGL', p.ORDER_NO+'40', '/security/roleAction.do?action=display', 'oz-permission-security-jsgl', ''
	   FROM OZ_SEC_PERMISSIONS p
       WHERE p.CODE = 'PID_SECURITY_QXGL';
	   
-- 插入权限配置数据.系统管理.组织架构管理
INSERT INTO OZ_SEC_PERMISSIONS(ID,PARENT_ID, TYPE, STATUS, INNER_FLAG, NAME, CODE, ORDER_NO, URL_PATH, CSS_CLASS, DESCRIPTION)
	   SELECT HIBERNATE_SEQUENCE.NEXTVAL,p.id, 0, 0, 'Y', 'oz.permission.organize.zuzhijiagouguanli', 'PID_ORGANIZE_ZZJGGL', p.ORDER_NO+'20', '', 'oz-permission-organize-zzjggl', ''
	   FROM OZ_SEC_PERMISSIONS p
       WHERE p.CODE = 'PID_MK_XTGL';
INSERT INTO OZ_SEC_PERMISSIONS(ID,PARENT_ID, TYPE, STATUS, INNER_FLAG, NAME, CODE, ORDER_NO, URL_PATH, CSS_CLASS, DESCRIPTION)
	   SELECT HIBERNATE_SEQUENCE.NEXTVAL,p.id, 0, 0, 'Y', 'oz.permission.organize.zuzhijiagou', 'PID_ORGANIZE_ZZJG', p.ORDER_NO+'10', '/organize/ouInfoAction.do?action=display', 'oz-permission-organize-zzjg', ''
	   FROM OZ_SEC_PERMISSIONS p
       WHERE p.CODE = 'PID_ORGANIZE_ZZJGGL';
INSERT INTO OZ_SEC_PERMISSIONS(ID,PARENT_ID, TYPE, STATUS, INNER_FLAG, NAME, CODE, ORDER_NO, URL_PATH, CSS_CLASS, DESCRIPTION)
	   SELECT HIBERNATE_SEQUENCE.NEXTVAL,p.id, 0, 0, 'Y', 'oz.permission.organize.gangweiguanli', 'PID_ORGANIZE_GWGL', p.ORDER_NO+'20', '/organize/groupAction.do?action=display', 'oz-permission-organize-gwgl', ''
	   FROM OZ_SEC_PERMISSIONS p
       WHERE p.CODE = 'PID_ORGANIZE_ZZJGGL';
INSERT INTO OZ_SEC_PERMISSIONS(ID,PARENT_ID, TYPE, STATUS, INNER_FLAG, NAME, CODE, ORDER_NO, URL_PATH, CSS_CLASS, DESCRIPTION)
	   SELECT HIBERNATE_SEQUENCE.NEXTVAL,p.id, 0, 0, 'Y', 'oz.permission.organize.yonghuguanli', 'PID_ORGANIZE_YHGL', p.ORDER_NO+'30', '/organize/userInfoAction.do?action=display', 'oz-permission-organize-yhgl', ''
	   FROM OZ_SEC_PERMISSIONS p
       WHERE p.CODE = 'PID_ORGANIZE_ZZJGGL';
INSERT INTO OZ_SEC_PERMISSIONS(ID,PARENT_ID, TYPE, STATUS, INNER_FLAG, NAME, CODE, ORDER_NO, URL_PATH, CSS_CLASS, DESCRIPTION)
	   SELECT HIBERNATE_SEQUENCE.NEXTVAL,p.id, 0, 0, 'Y', 'oz.permission.organize.zhiwuguanli', 'PID_ORGANIZE_ZWGL', p.ORDER_NO+'40', '/organize/jobTitleAction.do?action=display', 'oz-permission-organize-zwgl', ''
	   FROM OZ_SEC_PERMISSIONS p
       WHERE p.CODE = 'PID_ORGANIZE_ZZJGGL';	   
INSERT INTO OZ_SEC_PERMISSIONS(ID,PARENT_ID, TYPE, STATUS, INNER_FLAG, NAME, CODE, ORDER_NO, URL_PATH, CSS_CLASS, DESCRIPTION)
	   SELECT HIBERNATE_SEQUENCE.NEXTVAL,p.id, 0, 0, 'Y', 'oz.permission.organize.zhiwujibie', 'PID_ORGANIZE_ZWJB', p.ORDER_NO+'45', '/organize/jobLevelAction.do?action=display', 'oz-permission-organize-zwjb', ''
	   FROM OZ_SEC_PERMISSIONS p
       WHERE p.CODE = 'PID_ORGANIZE_ZZJGGL';
	   
	   

	   
	   
-- 插入权限配置数据.系统管理.系统配置管理
INSERT INTO OZ_SEC_PERMISSIONS(ID,PARENT_ID, TYPE, STATUS, INNER_FLAG, NAME, CODE, ORDER_NO, URL_PATH, CSS_CLASS, DESCRIPTION)
	   SELECT HIBERNATE_SEQUENCE.NEXTVAL,p.id, 0, 0, 'Y', 'oz.permission.systemconfig.xitongpeizhi', 'PID_SYSTEMCFG_XTPZ', p.ORDER_NO+'90', '', 'oz-permission-systemcfg-xtpz', ''
	   FROM OZ_SEC_PERMISSIONS p
       WHERE p.CODE = 'PID_MK_XTGL';	   
INSERT INTO OZ_SEC_PERMISSIONS(ID,PARENT_ID, TYPE, STATUS, INNER_FLAG, NAME, CODE, ORDER_NO, URL_PATH, CSS_CLASS, DESCRIPTION)
	   SELECT HIBERNATE_SEQUENCE.NEXTVAL,p.id, 0, 0, 'Y', 'oz.permission.systemconfig.jichushujupeizhi', 'PID_SYSTEMCFG_JCSJPZ', p.ORDER_NO+'10', '/config/configItemAction.do?action=display', 'oz-permission-systemcfg-jcsjpz', ''
	   FROM OZ_SEC_PERMISSIONS p
       WHERE p.CODE = 'PID_SYSTEMCFG_XTPZ';
INSERT INTO OZ_SEC_PERMISSIONS(ID,PARENT_ID, TYPE, STATUS, INNER_FLAG, NAME, CODE, ORDER_NO, URL_PATH, CSS_CLASS, DESCRIPTION)
	   SELECT HIBERNATE_SEQUENCE.NEXTVAL,p.id, 0, 0, 'Y', 'oz.permission.systemconfig.wendangleixing', 'PID_SYSTEMCFG_WDLX', p.ORDER_NO+'20', '/config/doctypeAction.do?action=display', 'oz-permission-systemcfg-wdlx', ''
	   FROM OZ_SEC_PERMISSIONS p
       WHERE p.CODE = 'PID_SYSTEMCFG_XTPZ';
INSERT INTO OZ_SEC_PERMISSIONS(ID,PARENT_ID, TYPE, STATUS, INNER_FLAG, NAME, CODE, ORDER_NO, URL_PATH, CSS_CLASS, DESCRIPTION)
	   SELECT HIBERNATE_SEQUENCE.NEXTVAL,p.id, 0, 0, 'Y', 'oz.permission.systemconfig.xitongkexuanxiang', 'PID_SYSTEMCFG_XTKXX', p.ORDER_NO+'30', '/config/optionItemAction.do?action=display', 'oz-permission-systemcfg-xtkxx', ''
	   FROM OZ_SEC_PERMISSIONS p
       WHERE p.CODE = 'PID_SYSTEMCFG_XTPZ';
INSERT INTO OZ_SEC_PERMISSIONS(ID,PARENT_ID, TYPE, STATUS, INNER_FLAG, NAME, CODE, ORDER_NO, URL_PATH, CSS_CLASS, DESCRIPTION)
	   SELECT HIBERNATE_SEQUENCE.NEXTVAL,p.id, 0, 0, 'Y', 'oz.permission.systemconfig.xitongcelue', 'PID_SYSTEMCFG_XTCL', p.ORDER_NO+'40', '/config/policyAction.do?action=display', 'oz-permission-systemcfg-xtcl', ''
	   FROM OZ_SEC_PERMISSIONS p
       WHERE p.CODE = 'PID_SYSTEMCFG_XTPZ';
INSERT INTO OZ_SEC_PERMISSIONS(ID,PARENT_ID, TYPE, STATUS, INNER_FLAG, NAME, CODE, ORDER_NO, URL_PATH, CSS_CLASS, DESCRIPTION)
	   SELECT HIBERNATE_SEQUENCE.NEXTVAL,p.id, 0, 0, 'Y', 'oz.permission.systemconfig.shouyepeizhi', 'PID_SYSTEMCFG_SYPZ', p.ORDER_NO+'50', '/module/portalAction.do?action=display', 'oz-permission-systemcfg-sypz', ''
	   FROM OZ_SEC_PERMISSIONS p
       WHERE p.CODE = 'PID_SYSTEMCFG_XTPZ';
INSERT INTO OZ_SEC_PERMISSIONS(ID,PARENT_ID, TYPE, STATUS, INNER_FLAG, NAME, CODE, ORDER_NO, URL_PATH, CSS_CLASS, DESCRIPTION)
	   SELECT HIBERNATE_SEQUENCE.NEXTVAL,p.id, 0, 0, 'Y', 'oz.permission.systemconfig.gongzuoshijian', 'PID_SYSTEMCFG_GZSJ', p.ORDER_NO+'60', '/module/businessHoursAction.do?action=open', 'oz-permission-systemcfg-gzsj', ''
	   FROM OZ_SEC_PERMISSIONS p
       WHERE p.CODE = 'PID_SYSTEMCFG_XTPZ';	   
INSERT INTO OZ_SEC_PERMISSIONS(ID,PARENT_ID, TYPE, STATUS, INNER_FLAG, NAME, CODE, ORDER_NO, URL_PATH, CSS_CLASS, DESCRIPTION)
	   SELECT HIBERNATE_SEQUENCE.NEXTVAL,p.id, 0, 0, 'Y', 'oz.permission.systemconfig.dingshirenwu', 'PID_SYSTEMCFG_DSRW', p.ORDER_NO+'70', '/config/schedulingJobAction.do?action=display', 'oz-permission-systemcfg-dsrw', ''
	   FROM OZ_SEC_PERMISSIONS p
       WHERE p.CODE = 'PID_SYSTEMCFG_XTPZ';	   
	   
-- 插入数据权限资源配置数据
INSERT INTO OZ_CMPN_ACL_DP_RESOURCE(ID,RESOURCE_NAME, RESOURCE_ID, DATASCOPE_TYPE) VALUES(HIBERNATE_SEQUENCE.NEXTVAL,'系统配置数据', 'datascope.resource.sysconfig', 0);

-- 插入超级管理员角色数据				 
INSERT INTO OZ_SEC_ROLE(ID,STATUS, INNER_FLAG, NAME, CODE, UNIT_ID)
	   SELECT HIBERNATE_SEQUENCE.NEXTVAL,0, 'N', '超级管理员', 'admin', unit.id
       FROM OZ_ORG_OUINFO unit
       WHERE unit.NAME = '设备管理系统';
INSERT INTO OZ_SEC_ROLE_PERMISSON(PERMISSION_ID, ROLE_ID)
       SELECT p.id, r.id 
       FROM OZ_SEC_ROLE r, OZ_SEC_PERMISSIONS p
       WHERE r.CODE = 'admin';
INSERT INTO OZ_ORG_GROUP_ROLE(GROUP_ID, ROLE_ID)
       SELECT g.id, r.id
       FROM OZ_ORG_GROUP g, OZ_SEC_ROLE r
       WHERE g.NAME = '超级管理岗' and r.CODE='admin';
       
-- 插入普通用户角色数据(先将所有权限给普通用户，由管理员再去删减)		 
INSERT INTO OZ_SEC_ROLE(ID,STATUS, INNER_FLAG, NAME, CODE, UNIT_ID)
	   SELECT HIBERNATE_SEQUENCE.NEXTVAL,0, 'N', '普通用户', 'COMM_USER', unit.id
       FROM OZ_ORG_OUINFO unit
       WHERE unit.NAME = '设备管理系统';
INSERT INTO OZ_SEC_ROLE_PERMISSON(PERMISSION_ID, ROLE_ID)
       SELECT p.id, r.id 
       FROM OZ_SEC_ROLE r, OZ_SEC_PERMISSIONS p
       WHERE r.CODE = 'COMM_USER';
INSERT INTO OZ_ORG_GROUP_ROLE(GROUP_ID, ROLE_ID)
       SELECT g.id, r.id
       FROM OZ_ORG_GROUP g, OZ_SEC_ROLE r
       WHERE r.CODE='COMM_USER';

-- 更新权限所属单位，请注意这一行要在最后
update OZ_SEC_PERMISSIONS set unit_id = (select ou.id from oz_org_ouinfo ou where ou.name='设备管理系统');

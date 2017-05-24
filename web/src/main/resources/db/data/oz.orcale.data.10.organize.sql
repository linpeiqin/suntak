/*===================================================== 数据导入编写说明 =================================================================*/
-- 1、在每一个数据插入前面描述该数据说明；
-- 2、如果该数据是测试数据，而非系统必须数据，则必须在数据导入说明前使用：/* TESTDATA */
/*===================================================== 数据导入编写说明 =================================================================*/
-- 食堂管理系统组织架构


INSERT INTO OZ_ORG_OUINFO(ID, STATUS, OU_TYPE, NAME, NAME_PINYIN, ORDER_NO, OU_RANK, TMP_OU,HEADCOUNT,ISALLOWEXCEED,FULL_NAME)
                   VALUES(HIBERNATE_SEQUENCE.NEXTVAL,0, 'DW', '设备管理系统', 'shebeiguanlixitong ', '00', 0, 'N',0,'Y','设备管理系统');

-- 插入组织架构数据.职务数据
INSERT INTO OZ_ORG_JOBTITLE(ID,NAME, CODE) VALUES(HIBERNATE_SEQUENCE.NEXTVAL,'职员', '999');
update OZ_ORG_JOBTITLE set UNIT_ID = (select ou.id from OZ_ORG_OUINFO ou where ou.name='设备管理系统');

-- 插入组织架构数据.职务级别数据
INSERT INTO OZ_ORG_JOBLEVEL(ID,NAME, JOBLEVEL) VALUES(HIBERNATE_SEQUENCE.NEXTVAL,'职员', 9);
update OZ_ORG_JOBLEVEL set UNIT_ID = (select ou.id from OZ_ORG_OUINFO ou where ou.name='设备管理系统');

-- 插入超级管理员岗位数据
INSERT INTO OZ_ORG_GROUP(ID,OUINFO_ID, INNER_FLAG, STATUS, NAME, NAME_PINYIN, CODE)
     SELECT HIBERNATE_SEQUENCE.NEXTVAL,unit.ID, 'Y', 0, '超级管理岗', 'chaojiguanligang', 'GW_ADMIN'
       FROM OZ_ORG_OUINFO unit
       WHERE unit.NAME = '设备管理系统';

-- 插入超级管理员
INSERT INTO OZ_SEC_USER(ID,STATUS, NAME, NAME_PINYIN, LOGIN_NAME, LOGIN_PASSWORD, IS_TMPUSER, LOCK_COUNT) 
               VALUES(HIBERNATE_SEQUENCE.NEXTVAL,0, '超级管理员', 'chaojiguanliyuan', 'admin', '(5f4dcc3b5aa765d61d8327deb882cf99)', 'N', 0);
               
INSERT INTO OZ_ORG_USERINFO(ID,OUINFO_ID, STATUS, NAME, NAME_PINYIN, LOGIN_NAME, ORDER_NO, IS_DEFAULT, JOBTITLE_ID, JOBLEVEL_ID)
     SELECT HIBERNATE_SEQUENCE.NEXTVAL,ouInfo.ID, 0, '超级管理员', 'chaojiguanliyuan', 'admin', '99', 'Y', jobTitle.ID, jobLevel.ID
       FROM OZ_ORG_OUINFO ouInfo, OZ_ORG_JOBTITLE jobTitle, OZ_ORG_JOBLEVEL jobLevel       
       WHERE ouInfo.NAME = '设备管理系统' and jobTitle.NAME = '职员' and jobLevel.NAME = '职员';
       
INSERT INTO OZ_ORG_USERINFO_GROUP(USERINFO_ID, GROUP_ID)
       SELECT userinfo.id, g.id
       FROM OZ_ORG_GROUP g, OZ_ORG_USERINFO userinfo
       WHERE g.NAME = '超级管理岗' and userinfo.LOGIN_NAME='admin';  

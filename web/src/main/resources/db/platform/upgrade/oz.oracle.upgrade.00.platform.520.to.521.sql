/*
 * Copyright (c) 2010 - OZ Wizards Group. 
 * All rights reserved.
 * 
 * Created on 2013-07-11
 * @author CD826
 * @version 5.2.1
 */
/* ==================================================================================================================*/	  
/* 平台由5.2.0升级为5.2.1时的数据库升级脚本                                                                          */	  
/* ==================================================================================================================*/	  
/*==============================================================*/
/* Table: OZ_ORG_GROUPTPL -- 岗位配置模板表                     */
/*==============================================================*/
CREATE TABLE OZ_ORG_GROUPTPL  (
   ID                   NUMBER(19)                      NOT NULL,
   NAME                 VARCHAR2(255)                   NOT NULL,
   UNIT_ID              VARCHAR2(255),
   MEMOS                VARCHAR2(255),
   CONSTRAINT PK_OZ_ORG_GROUPTPL PRIMARY KEY (ID)
);
COMMENT ON TABLE OZ_ORG_GROUPTPL IS '岗位配置模板表';
COMMENT ON COLUMN OZ_ORG_GROUPTPL.NAME IS '岗位模板名称';
COMMENT ON COLUMN OZ_ORG_GROUPTPL.UNIT_ID IS '配置所属单位';
COMMENT ON COLUMN OZ_ORG_GROUPTPL.MEMOS IS '岗位模板描述';

CREATE INDEX IDX_OZ_ORG_GROUPTPL_UNIT ON OZ_ORG_GROUPTPL (UNIT_ID ASC);


/*==============================================================*/
/* Table: OZ_ORG_GROUPTPL_GROUP -- 岗位模板与岗位的关联表       */
/*==============================================================*/
CREATE TABLE OZ_ORG_GROUPTPL_GROUP  (
   TPL_ID               NUMBER(19)                      NOT NULL,
   GROUP_ID             NUMBER(19)                      NOT NULL,
   CONSTRAINT PK_OZ_ORG_GROUPTPL_GROUP PRIMARY KEY (GROUP_ID, TPL_ID)
);
COMMENT ON TABLE OZ_ORG_GROUPTPL_GROUP IS '岗位模板与岗位的关联表';
COMMENT ON COLUMN OZ_ORG_GROUPTPL_GROUP.TPL_ID IS '模板ID';
COMMENT ON COLUMN OZ_ORG_GROUPTPL_GROUP.GROUP_ID IS '岗位ID';
CREATE INDEX IDX_OZ_ORG_GTPL_G ON OZ_ORG_GROUPTPL_GROUP (GROUP_ID ASC);
CREATE INDEX IDX_OZ_ORG_GTPL_TPL ON OZ_ORG_GROUPTPL_GROUP (TPL_ID ASC);

ALTER TABLE OZ_ORG_GROUPTPL_GROUP
      ADD CONSTRAINT FK_OZ_ORG_GTPL_REF_TPL FOREIGN KEY (TPL_ID)
      REFERENCES OZ_ORG_GROUPTPL (ID);
ALTER TABLE OZ_ORG_GROUPTPL_GROUP
      ADD CONSTRAINT FK_OZ_ORG_GTPL_REF_G FOREIGN KEY (GROUP_ID)
      REFERENCES OZ_ORG_GROUP (ID);


--- 对组织架构表进行扩展
ALTER TABLE OZ_ORG_OUINFO ADD DEFAULT_ROLEID VARCHAR2(255);
COMMENT ON COLUMN OZ_ORG_OUINFO.DEFAULT_ROLEID IS '缺省角色的ID';

ALTER TABLE OZ_ORG_OUINFO ADD THIRD_ID VARCHAR2(255);
COMMENT ON COLUMN OZ_ORG_USERINFO.THIRD_ID IS '';


--- 对岗位配置表进行扩展
ALTER TABLE OZ_ORG_GROUP ADD ORDER_NO VARCHAR2(255);
COMMENT ON COLUMN OZ_ORG_GROUP.ORDER_NO IS '岗位排序号';
UPDATE OZ_ORG_GROUP T SET T.ORDER_NO = T.CODE, T.CODE='';

ALTER OZ_ORG_USERINFO THIRD_ID

ALTER TABLE OZ_ORG_USERINFO ADD THIRD_ID VARCHAR2(255);
COMMENT ON COLUMN OZ_ORG_USERINFO.THIRD_ID IS '';


/* ==================================================================================================================*/	  
/* 5.2.1 build-000 插入并设置数据设计的版本为5.2.1 build-000                                                         */
/* ==================================================================================================================*/	   
UPDATE OZ_SYS_VERSION SET REVISION='1', BUILD='000', DEPLOYMNET_DATE=sysdate WHERE SYSTEM_ID='platform-db';


/* ==================================================================================================================*/	  
/* 5.2.1 build-001 设置数据设计的版本为5.2.1 build-001                                                               */
/* ==================================================================================================================*/	   
UPDATE OZ_SYS_VERSION SET BUILD='001', DEPLOYMNET_DATE=sysdate WHERE SYSTEM_ID='platform-db';
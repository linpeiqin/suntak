/*
 * Copyright (c) 2010 - OZ Wizards Group. 
 * All rights reserved.
 *
 * Created on 2012-05-08
 * @author CD826
 * @version 5.2.0
 */
/* oz-config ========================================================================================================*/
/*==============================================================*/
/* Table: OZ_CFG_DATADICT -- 数据字典                           */
/*==============================================================*/
CREATE TABLE OZ_CFG_DATADICT  (
   ID                   NUMBER(19)                      NOT NULL,
   PARENT_ID            NUMBER(19),
   NAME                 VARCHAR2(255)                   NOT NULL,
   VALUE                VARCHAR2(255)                   NOT NULL,
   ORDER_NO             VARCHAR2(255),
   IS_INNER             VARCHAR2(1)                     NOT NULL,
   IS_DEFAULT           VARCHAR2(1)                     NOT NULL,
   CONSTRAINT PK_OZ_CFG_DATADICT PRIMARY KEY (ID)
);
COMMENT ON TABLE OZ_CFG_DATADICT IS '数据字典';
COMMENT ON COLUMN OZ_CFG_DATADICT.PARENT_ID IS '所属父';
COMMENT ON COLUMN OZ_CFG_DATADICT.NAME IS '名称';
COMMENT ON COLUMN OZ_CFG_DATADICT.VALUE IS '值';
COMMENT ON COLUMN OZ_CFG_DATADICT.ORDER_NO IS '排序';
COMMENT ON COLUMN OZ_CFG_DATADICT.IS_INNER IS '是否内置';
COMMENT ON COLUMN OZ_CFG_DATADICT.IS_DEFAULT IS '是否缺省值';

ALTER TABLE OZ_CFG_DATADICT
      ADD CONSTRAINT FK_OZ_CFG_DD_REF_P FOREIGN KEY (PARENT_ID)
      REFERENCES OZ_CFG_DATADICT (ID);

	  
/* oz-system-admin ==================================================================================================*/	  
/*==============================================================*/
/* Table: OZ_SYS_VERSION -- 系统版本号                          */
/*==============================================================*/
CREATE TABLE OZ_SYS_VERSION  (
   ID                   NUMBER(19)                      NOT NULL,
   SYSTEM_ID            VARCHAR2(255)                   NOT NULL,
   MAJOR                NUMBER(4)                       NOT NULL,
   MINOR                NUMBER(4)                       NOT NULL,
   REVISION             NUMBER(4)                       NOT NULL,
   BUILD                NUMBER(4),
   CLASSIFICATION       VARCHAR2(255),
   DEPLOYMNET_DATE      DATE,
   CONSTRAINT PK_OZ_SYS_VERSION PRIMARY KEY (ID)
);
COMMENT ON TABLE OZ_SYS_VERSION IS '系统版本号';
COMMENT ON COLUMN OZ_SYS_VERSION.SYSTEM_ID IS '系统名称';
COMMENT ON COLUMN OZ_SYS_VERSION.MAJOR IS '主版本号';
COMMENT ON COLUMN OZ_SYS_VERSION.MINOR IS '次版本号';
COMMENT ON COLUMN OZ_SYS_VERSION.REVISION IS '修订号';
COMMENT ON COLUMN OZ_SYS_VERSION.BUILD IS '内部版本号';
COMMENT ON COLUMN OZ_SYS_VERSION.CLASSIFICATION IS '版本分类';
COMMENT ON COLUMN OZ_SYS_VERSION.DEPLOYMNET_DATE IS '部署时间';


/* ==================================================================================================================*/	  
/* 5.2.0 build-521 插入并设置数据设计的版本为5.2.0 build-521                                                         */
/* ==================================================================================================================*/
INSERT INTO OZ_SYS_VERSION(ID, SYSTEM_ID, MAJOR, MINOR, REVISION, BUILD, CLASSIFICATION, DEPLOYMNET_DATE)
	   VALUES(HIBERNATE_SEQUENCE.NEXTVAL, 'platform-db', 5, 2, 0, 521, 'SNAPSHOT', sysdate);
	   
	   
/* ==================================================================================================================*/
/*==============================================================*/
/* Table: OZ_ORG_CHARGEDEPATS -- 分管部门配置表                 */
/*==============================================================*/
CREATE TABLE OZ_ORG_CHARGEDEPATS  (
   OUINFO_ID            NUMBER(19)                      NOT NULL,
   USERINFO_ID          NUMBER(19)                      NOT NULL,
   CONSTRAINT PK_OZ_ORG_CHARGEDEPATS PRIMARY KEY (OUINFO_ID, USERINFO_ID)
);
COMMENT ON TABLE OZ_ORG_CHARGEDEPATS IS '分管部门配置表';
COMMENT ON COLUMN OZ_ORG_CHARGEDEPATS.OUINFO_ID IS '组织架构ID';
COMMENT ON COLUMN OZ_ORG_CHARGEDEPATS.USERINFO_ID IS '人员ID';

CREATE INDEX IDX_OZ_ORG_CD_OUINFO ON OZ_ORG_CHARGEDEPATS (OUINFO_ID ASC);
CREATE INDEX IDX_OZ_ORG_CD_USERINFO ON OZ_ORG_CHARGEDEPATS (USERINFO_ID ASC);

ALTER TABLE OZ_ORG_CHARGEDEPATS
      ADD CONSTRAINT FK_OZ_ORG_C_REFERENCE_OZ_ORG_U FOREIGN KEY (USERINFO_ID)
      REFERENCES OZ_ORG_USERINFO (ID);
ALTER TABLE OZ_ORG_CHARGEDEPATS
      ADD CONSTRAINT FK_OZ_ORG_C_REFERENCE_OZ_ORG_O FOREIGN KEY (OUINFO_ID)
      REFERENCES OZ_ORG_OUINFO (ID);


/* ==================================================================================================================*/
/*==============================================================*/
/* Table: OZ_APP_CONFIGDATA -- 系统数据配置表                   */
/*==============================================================*/
CREATE TABLE OZ_APP_CONFIGDATA  (
   ID                   NUMBER(19)                      NOT NULL,
   CFG_TYPE             VARCHAR2(255),
   CFG_KEY              VARCHAR2(255)                   NOT NULL,
   CFG_VALUE            VARCHAR2(4000),
   IS_ENABLE            VARCHAR2(1),
   CONSTRAINT PK_OZ_APP_CONFIGDATA PRIMARY KEY (ID)
);
COMMENT ON TABLE OZ_APP_CONFIGDATA IS '系统数据配置表';
COMMENT ON COLUMN OZ_APP_CONFIGDATA.CFG_TYPE IS '配置数据类型';
COMMENT ON COLUMN OZ_APP_CONFIGDATA.CFG_KEY IS '名称';
COMMENT ON COLUMN OZ_APP_CONFIGDATA.CFG_VALUE IS '值';
COMMENT ON COLUMN OZ_APP_CONFIGDATA.IS_ENABLE IS '配置状态';

CREATE INDEX IDX_OZ_APP_CFGDATA_TYPE ON OZ_APP_CONFIGDATA (CFG_TYPE ASC);
CREATE INDEX IDX_OZ_APP_CFGDATA_KEY ON OZ_APP_CONFIGDATA (CFG_KEY ASC);



	  
/*==============================================================*/
/* Table: OZ_SEC_PERMISSION_ENTITY -- 权限条目信息              */
/*==============================================================*/
CREATE TABLE OZ_SEC_PERMISSION_ENTITY  (
   ID                   NUMBER(19)                      NOT NULL,
   ROLE_ID              NUMBER(19),
   USER_ID              NUMBER(19),
   CODE                 VARCHAR2(255)                   NOT NULL,
   CONSTRAINT PK_OZ_SEC_PERMISSION_ENTITY PRIMARY KEY (ID)
);
COMMENT ON TABLE OZ_SEC_PERMISSION_ENTITY IS '权限条目信息';
COMMENT ON COLUMN OZ_SEC_PERMISSION_ENTITY.ROLE_ID IS '所属角色';
COMMENT ON COLUMN OZ_SEC_PERMISSION_ENTITY.USER_ID IS '所属用户';
COMMENT ON COLUMN OZ_SEC_PERMISSION_ENTITY.CODE IS '权限编码';

CREATE INDEX IDX_OZ_SEC_PE_ROLE ON OZ_SEC_PERMISSION_ENTITY (ROLE_ID ASC);
CREATE INDEX IDX_OZ_SEC_PE_USER ON OZ_SEC_PERMISSION_ENTITY (USER_ID ASC);

ALTER TABLE OZ_SEC_PERMISSION_ENTITY
      ADD CONSTRAINT FK_OZ_SEC_PE_REF_ROLE FOREIGN KEY (ROLE_ID)
      REFERENCES OZ_SEC_ROLE (ID);
ALTER TABLE OZ_SEC_PERMISSION_ENTITY
      ADD CONSTRAINT FK_OZ_SEC_PE_REF_USER FOREIGN KEY (USER_ID)
      REFERENCES OZ_SEC_USER (ID);




/*==============================================================*/
/* Table: OZ_ORG_PRIVATEGROUP -- 私有群组配置表                 */
/*==============================================================*/
CREATE TABLE OZ_ORG_PRIVATEGROUP  (
   ID                   NUMBER(19)                      NOT NULL,
   USERINFO_ID          VARCHAR2(36),
   NAME                 VARCHAR2(255),
   CODE                 VARCHAR2(255),
   GROUP_TYPE           VARCHAR2(255),
   MEMOS                VARCHAR2(255),
   CONSTRAINT PK_OZ_ORG_PRIVATEGROUP PRIMARY KEY (ID)
);
COMMENT ON TABLE OZ_ORG_PRIVATEGROUP IS '私有群组配置表';
COMMENT ON COLUMN OZ_ORG_PRIVATEGROUP.USERINFO_ID IS '所属人员的ID';
COMMENT ON COLUMN OZ_ORG_PRIVATEGROUP.NAME IS '岗位名称';
COMMENT ON COLUMN OZ_ORG_PRIVATEGROUP.CODE IS '岗位编码';
COMMENT ON COLUMN OZ_ORG_PRIVATEGROUP.GROUP_TYPE IS '岗位类型';
COMMENT ON COLUMN OZ_ORG_PRIVATEGROUP.MEMOS IS '岗位描述';

CREATE INDEX IDX_OZ_ORG_PRIVATEGROUP_UI ON OZ_ORG_PRIVATEGROUP (USERINFO_ID ASC);


/*==============================================================*/
/* Table: OZ_ORG_USERINFO_PRIVATEGROUP -- 人员私有群组关联表    */
/*==============================================================*/
CREATE TABLE OZ_ORG_USERINFO_PRIVATEGROUP  (
   USERINFO_ID          NUMBER(19)                      NOT NULL,
   PRIVATEGROUP_ID      NUMBER(19)                      NOT NULL,
   CONSTRAINT PK_OZ_ORG_USERINFO_PRIVATEGROU PRIMARY KEY (PRIVATEGROUP_ID, USERINFO_ID)
);
COMMENT ON TABLE OZ_ORG_USERINFO_PRIVATEGROUP IS '人员私有群组关联表';
COMMENT ON COLUMN OZ_ORG_USERINFO_PRIVATEGROUP.USERINFO_ID IS '人员ID';
COMMENT ON COLUMN OZ_ORG_USERINFO_PRIVATEGROUP.PRIVATEGROUP_ID IS '群组ID';

CREATE INDEX IDX_OZ_ORG_UG_G2 ON OZ_ORG_USERINFO_PRIVATEGROUP (PRIVATEGROUP_ID ASC);
CREATE INDEX IDX_OZ_ORG_UG_U2 ON OZ_ORG_USERINFO_PRIVATEGROUP (USERINFO_ID ASC);

ALTER TABLE OZ_ORG_USERINFO_PRIVATEGROUP
      ADD CONSTRAINT FK_OZ_ORG_UPG_REF_U FOREIGN KEY (USERINFO_ID)
      REFERENCES OZ_ORG_USERINFO (ID);
ALTER TABLE OZ_ORG_USERINFO_PRIVATEGROUP
      ADD CONSTRAINT FK_OZ_ORG_UPG_REF_PG FOREIGN KEY (PRIVATEGROUP_ID)
      REFERENCES OZ_ORG_PRIVATEGROUP (ID);

	  
/* ==================================================================================================================*/	  
/* 5.2.0 build-531 更新数据设计的版本为5.2.0 build-531                                                               */
/* ==================================================================================================================*/
UPDATE OZ_SYS_VERSION SET BUILD='531', DEPLOYMNET_DATE=sysdate WHERE SYSTEM_ID='platform-db';	  



/* 为授权日志增加收回及处理标志 =====================================================================================*/
ALTER TABLE OZ_CMPN_WORK_PROXYWORK ADD RETRIEVE_FLAG VARCHAR2(8);
ALTER TABLE OZ_CMPN_WORK_PROXYWORK ADD PROCESSED_DATE DATE;
COMMENT ON COLUMN OZ_CMPN_WORK_PROXYWORK.RETRIEVE_FLAG IS '授权事务收回标志';
COMMENT ON COLUMN OZ_CMPN_WORK_PROXYWORK.PROCESSED_DATE IS '事务处理时间';


/* ==================================================================================================================*/	  
/* 5.2.0 build-532 插入并设置数据设计的版本为5.2.0 build-532                                                         */
/* ==================================================================================================================*/	   
UPDATE OZ_SYS_VERSION SET BUILD='532', DEPLOYMNET_DATE=sysdate WHERE SYSTEM_ID='platform-db';   


/* 为文种的权限配置增加名称信息 =====================================================================================*/
-- Add/modify columns 
alter table OZ_DOC_DEF_ELEMENTRIGHT add factor_name VARCHAR2(255);
-- Add comments to the columns 
comment on column OZ_DOC_DEF_ELEMENTRIGHT.factor_name
  is '控制因素名称';

/* ==================================================================================================================*/	  
/* 5.2.0 build-533 插入并设置数据设计的版本为5.2.0 build-533                                                         */
/* ==================================================================================================================*/	   
UPDATE OZ_SYS_VERSION SET BUILD='533', DEPLOYMNET_DATE=sysdate WHERE SYSTEM_ID='platform-db';  



/*==============================================================*/
/* Table: OZ_ORG_USERINFORELATION -- 用户关系表                 */
/*==============================================================*/
CREATE TABLE OZ_ORG_USERINFORELATION  (
   ID                   NUMBER(19)                      NOT NULL,
   LHUSERINFO_ID        NUMBER(19),
   RHUSERINFO_ID        NUMBER(19),
   RELATION_TYPE        VARCHAR2(255),
   MEMOS                VARCHAR2(255),
   CONSTRAINT PK_OZ_ORG_USERINFORELATION PRIMARY KEY (ID)
);
COMMENT ON TABLE OZ_ORG_USERINFORELATION IS '用户关系表';
COMMENT ON COLUMN OZ_ORG_USERINFORELATION.LHUSERINFO_ID IS '所属人员ID';
COMMENT ON COLUMN OZ_ORG_USERINFORELATION.RHUSERINFO_ID IS '关联人员ID';
COMMENT ON COLUMN OZ_ORG_USERINFORELATION.RELATION_TYPE IS '关联关系';
COMMENT ON COLUMN OZ_ORG_USERINFORELATION.MEMOS IS '备注描述';

CREATE INDEX IDX_OZ_ORG_UIR_LHU ON OZ_ORG_USERINFORELATION (LHUSERINFO_ID ASC);
CREATE INDEX IDX_OZ_ORG_UIR_RHU ON OZ_ORG_USERINFORELATION (RHUSERINFO_ID ASC);

ALTER TABLE OZ_ORG_USERINFORELATION
      ADD CONSTRAINT FK_OZ_ORG_UIR_REF_LHUI FOREIGN KEY (LHUSERINFO_ID)
      REFERENCES OZ_ORG_USERINFO (ID);
ALTER TABLE OZ_ORG_USERINFORELATION
      ADD CONSTRAINT FK_OZ_ORG_UIR_REF_RHUI FOREIGN KEY (RHUSERINFO_ID)
      REFERENCES OZ_ORG_USERINFO (ID);

	  
/*==============================================================*/
/* Table: OZ_ORG_RELATED_AUTHZ -- 用户关联授权信息表            */
/*==============================================================*/
CREATE TABLE OZ_ORG_RELATED_AUTHZ  (
   ID                   NUMBER(19)                      NOT NULL,
   RELATION_ID          NUMBER(19),
   AUTHZ_CODE           VARCHAR2(255)                   NOT NULL,
   CONSTRAINT PK_OZ_ORG_RELATED_AUTHZ PRIMARY KEY (ID)
);
COMMENT ON TABLE OZ_ORG_RELATED_AUTHZ IS '用户关联授权信息表';
COMMENT ON COLUMN OZ_ORG_RELATED_AUTHZ.RELATION_ID IS '所属关系ID';
COMMENT ON COLUMN OZ_ORG_RELATED_AUTHZ.AUTHZ_CODE IS '授权编码';

CREATE INDEX IDX_OZ_ORG_UIR_LHU2 ON OZ_ORG_RELATED_AUTHZ (RELATION_ID ASC);
CREATE INDEX IDX_OZ_ORG_UIR_RHU2 ON OZ_ORG_RELATED_AUTHZ (AUTHZ_CODE ASC);

ALTER TABLE OZ_ORG_RELATED_AUTHZ
      ADD CONSTRAINT FK_OZ_ORG_RA_REF_UIR FOREIGN KEY (RELATION_ID)
      REFERENCES OZ_ORG_USERINFORELATION (ID);
	  


/*==============================================================*/
/* Table: OZ_ORG_GROUP_PRIVATEGROUP -- 便捷组-岗位关联表        */
/*==============================================================*/
CREATE TABLE OZ_ORG_GROUP_PRIVATEGROUP  (
   GROUP_ID             NUMBER(19)                      NOT NULL,
   PRIVATEGROUP_ID      NUMBER(19)                      NOT NULL,
   CONSTRAINT PK_OZ_ORG_GROUP_PRIVATEGROUP PRIMARY KEY (GROUP_ID, PRIVATEGROUP_ID)
);
COMMENT ON TABLE OZ_ORG_GROUP_PRIVATEGROUP IS '便捷组-岗位关联表';
COMMENT ON COLUMN OZ_ORG_GROUP_PRIVATEGROUP.GROUP_ID IS '岗位ID';
COMMENT ON COLUMN OZ_ORG_GROUP_PRIVATEGROUP.PRIVATEGROUP_ID IS '便捷组ID';

CREATE INDEX IDX_ORG_GP_G ON OZ_ORG_GROUP_PRIVATEGROUP (GROUP_ID ASC);
CREATE INDEX IDX_ORG_GP_P ON OZ_ORG_GROUP_PRIVATEGROUP (PRIVATEGROUP_ID ASC);

ALTER TABLE OZ_ORG_GROUP_PRIVATEGROUP
      ADD CONSTRAINT FK_OZ_ORG_PG_G_REF_G FOREIGN KEY (GROUP_ID)
      REFERENCES OZ_ORG_GROUP (ID);
ALTER TABLE OZ_ORG_GROUP_PRIVATEGROUP
      ADD CONSTRAINT FK_OZ_ORG_PG_G_REF_PG FOREIGN KEY (PRIVATEGROUP_ID)
      REFERENCES OZ_ORG_PRIVATEGROUP (ID);

/*==============================================================*/
/* Table: OZ_ORG_OUINFO_PRIVATEGROUP -- 便捷组-组织架构关联表   */
/*==============================================================*/
CREATE TABLE OZ_ORG_OUINFO_PRIVATEGROUP  (
   OUINFO_ID            NUMBER(19)                      NOT NULL,
   PRIVATEGROUP_ID      NUMBER(19)                      NOT NULL,
   CONSTRAINT PK_OZ_ORG_OUINFO_PRIVATEGROUP PRIMARY KEY (OUINFO_ID, PRIVATEGROUP_ID)
);
COMMENT ON TABLE OZ_ORG_OUINFO_PRIVATEGROUP IS '便捷组-组织架构关联表';
COMMENT ON COLUMN OZ_ORG_OUINFO_PRIVATEGROUP.OUINFO_ID IS '组织架构ID';
COMMENT ON COLUMN OZ_ORG_OUINFO_PRIVATEGROUP.PRIVATEGROUP_ID IS '便捷组ID';

CREATE INDEX IDX_ORG_PG_OU_OU ON OZ_ORG_OUINFO_PRIVATEGROUP (OUINFO_ID ASC);
CREATE INDEX IDX_ORG_PG_OU_PG ON OZ_ORG_OUINFO_PRIVATEGROUP (PRIVATEGROUP_ID ASC);

ALTER TABLE OZ_ORG_OUINFO_PRIVATEGROUP
      ADD CONSTRAINT FK_OZ_ORG_PG_OU_REF_PG FOREIGN KEY (PRIVATEGROUP_ID)
      REFERENCES OZ_ORG_PRIVATEGROUP (ID);
ALTER TABLE OZ_ORG_OUINFO_PRIVATEGROUP
      ADD CONSTRAINT FK_OZ_ORG_PG_OU_REF_OU FOREIGN KEY (OUINFO_ID)
      REFERENCES OZ_ORG_OUINFO (ID);

-- 添加便捷组的所属单位
ALTER TABLE OZ_ORG_PRIVATEGROUP ADD UNIT_ID VARCHAR2(36);
COMMENT ON COLUMN OZ_ORG_PRIVATEGROUP.UNIT_ID IS '所属单位的ID';

/* ==================================================================================================================*/	  
/* 5.2.0 build-537 插入并设置数据设计的版本为5.2.0 build-537                                                         */
/* ==================================================================================================================*/	   




-- 组织架构更新
/*==============================================================*/
/* Table: OZ_ORG_OULEVEL -- 组织架构级别配置表                  */
/*==============================================================*/
CREATE TABLE OZ_ORG_OULEVEL  (
   ID                   NUMBER(19)                      NOT NULL,
   PARENT_ID            NUMBER(19),
   NAME                 VARCHAR2(255)                   NOT NULL,
   OULEVEL              NUMBER(2)                       NOT NULL,
   DESCRIPTION          VARCHAR2(255),
   CONSTRAINT PK_OZ_ORG_OULEVEL PRIMARY KEY (ID)
);
COMMENT ON TABLE OZ_ORG_OULEVEL IS '组织架构级别配置表';
COMMENT ON COLUMN OZ_ORG_OULEVEL.PARENT_ID IS '上级级别';
COMMENT ON COLUMN OZ_ORG_OULEVEL.NAME IS '级别名称';
COMMENT ON COLUMN OZ_ORG_OULEVEL.OULEVEL IS '级别';
COMMENT ON COLUMN OZ_ORG_OULEVEL.DESCRIPTION IS '备注说明';

CREATE INDEX IDX_OZ_ORG_OUL_PARENT ON OZ_ORG_OULEVEL (PARENT_ID ASC);
ALTER TABLE OZ_ORG_OULEVEL
      ADD CONSTRAINT FK_OZ_ORG_OUL_REF_PARENT FOREIGN KEY (PARENT_ID)
      REFERENCES OZ_ORG_OULEVEL (ID);


-- 组织架构更新	  
ALTER TABLE OZ_ORG_OUINFO ADD OULEVEL_ID NUMBER(19);
ALTER TABLE OZ_ORG_OUINFO ADD HEADCOUNT NUMBER(8);
ALTER TABLE OZ_ORG_OUINFO ADD ISALLOWEXCEED VARCHAR2(1);
ALTER TABLE OZ_ORG_OUINFO ADD SHORT_CODE VARCHAR2(255);
ALTER TABLE OZ_ORG_OUINFO ADD RESPONSIBILITY VARCHAR2(4000);

COMMENT ON COLUMN OZ_ORG_OUINFO.OULEVEL_ID IS '组织架构的级别';
COMMENT ON COLUMN OZ_ORG_OUINFO.HEADCOUNT IS '编制';
COMMENT ON COLUMN OZ_ORG_OUINFO.ISALLOWEXCEED IS '是否允许超编';
COMMENT ON COLUMN OZ_ORG_OUINFO.SHORT_CODE IS '助记码';
COMMENT ON COLUMN OZ_ORG_OUINFO.RESPONSIBILITY IS '职责';

CREATE INDEX IDX_OZ_ORG_OUINFO_LEVEL ON OZ_ORG_OUINFO (OULEVEL_ID ASC);
ALTER TABLE OZ_ORG_OUINFO
      ADD CONSTRAINT FK_OZ_ORG_OU_REF_OUL FOREIGN KEY (OULEVEL_ID)
      REFERENCES OZ_ORG_OULEVEL (ID);

-- 更新组织架构中的数据	  
UPDATE OZ_ORG_OUINFO SET HEADCOUNT=0, ISALLOWEXCEED='Y';

	  
/* ==================================================================================================================*/	  
/* 5.2.0 build-539 插入并设置数据设计的版本为5.2.0 build-540                                                         */
/* ==================================================================================================================*/	   
UPDATE OZ_SYS_VERSION SET BUILD='540', DEPLOYMNET_DATE=sysdate WHERE SYSTEM_ID='platform-db'; 




-- 修改可选项配置
ALTER TABLE OZ_CFG_OPTIONGROUP ADD EDITABLE_FLAG VARCHAR2(1);
COMMENT ON COLUMN OZ_CFG_OPTIONGROUP.EDITABLE_FLAG IS '是否可以进行编辑';
ALTER TABLE OZ_CFG_OPTIONGROUP ADD MGM_TYPE VARCHAR2(8);
COMMENT ON COLUMN OZ_CFG_OPTIONGROUP.MGM_TYPE IS '配置管理方式,CM:集权,DM:分级';
ALTER TABLE OZ_CFG_OPTIONGROUP ADD MEMOS VARCHAR2(255);
COMMENT ON COLUMN OZ_CFG_OPTIONGROUP.MEMOS IS '信息备注';
UPDATE OZ_CFG_OPTIONGROUP SET EDITABLE_FLAG='Y', MGM_TYPE='CM'; 
UPDATE OZ_CFG_OPTIONENTRY SET UNIT_ID='-1';

/* ==================================================================================================================*/	  
/* 5.2.0 build-541 插入并设置数据设计的版本为5.2.0 build-541                                                         */
/* ==================================================================================================================*/	   
UPDATE OZ_SYS_VERSION SET BUILD='541', DEPLOYMNET_DATE=sysdate WHERE SYSTEM_ID='platform-db';




-- 修改组织架构
ALTER TABLE OZ_ORG_OUINFO ADD FULL_NAME VARCHAR2(255);
COMMENT ON COLUMN OZ_ORG_OUINFO.FULL_NAME IS '全称';
ALTER TABLE OZ_ORG_OUINFO ADD FULL_CODE VARCHAR2(255);
COMMENT ON COLUMN OZ_ORG_OUINFO.FULL_CODE IS '全编码';
CREATE INDEX IDX_OZ_ORG_OUINFO_FC ON OZ_ORG_OUINFO (FULL_CODE ASC);
ALTER TABLE OZ_ORG_OUINFO MODIFY TYPE VARCHAR2(32);

/* ==================================================================================================================*/	  
/* 5.2.0 build-542 插入并设置数据设计的版本为5.2.0 build-542                                                         */
/* ==================================================================================================================*/	   
UPDATE OZ_SYS_VERSION SET BUILD='542', DEPLOYMNET_DATE=sysdate WHERE SYSTEM_ID='platform-db';



/* ==================================================================================================================*/	  
/* 5.2.0 build-543 插入并设置数据设计的版本为5.2.0 build-543                                                         */
/* ==================================================================================================================*/	   
UPDATE OZ_SYS_VERSION SET BUILD='543', DEPLOYMNET_DATE=sysdate WHERE SYSTEM_ID='platform-db';




--- 单位信息中增加简称
ALTER TABLE OZ_ORG_OUINFO ADD ABBR_NAME VARCHAR2(255);
COMMENT ON COLUMN OZ_ORG_OUINFO.ABBR_NAME IS '单位简称';

/* ==================================================================================================================*/	  
/* 5.2.0 build-544 插入并设置数据设计的版本为5.2.0 build-544                                                         */
/* ==================================================================================================================*/	   
UPDATE OZ_SYS_VERSION SET BUILD='544', DEPLOYMNET_DATE=sysdate WHERE SYSTEM_ID='platform-db';



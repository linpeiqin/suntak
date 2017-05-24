-- 插入系统全局配置数据
INSERT INTO OZ_CFG_CONFIG(ID,CFG_KEY, CFG_VALUE) VALUES(hibernate_sequence.NEXTVAL,'system.id', 'ems');
INSERT INTO OZ_CFG_CONFIG(ID,CFG_KEY, CFG_VALUE) VALUES(hibernate_sequence.NEXTVAL,'system.title', '设备管理系统');
INSERT INTO OZ_CFG_CONFIG(ID,CFG_KEY, CFG_VALUE) VALUES(hibernate_sequence.NEXTVAL,'system.short.title', '设备管理系统');
INSERT INTO OZ_CFG_CONFIG(ID,CFG_KEY, CFG_VALUE) VALUES(hibernate_sequence.NEXTVAL,'system.version.no', '5.2.1');
INSERT INTO OZ_CFG_CONFIG(ID,CFG_KEY, CFG_VALUE) VALUES(hibernate_sequence.NEXTVAL,'system.copyright', '设备管理系统  版权所有 2016-');
INSERT INTO OZ_CFG_CONFIG(ID,CFG_KEY, CFG_VALUE) VALUES(hibernate_sequence.NEXTVAL,'system.fullWindow', 'false');
INSERT INTO OZ_CFG_CONFIG(ID,CFG_KEY, CFG_VALUE) VALUES(hibernate_sequence.NEXTVAL,'system.debug', 'true');
INSERT INTO OZ_CFG_CONFIG(ID,CFG_KEY, CFG_VALUE) VALUES(hibernate_sequence.NEXTVAL,'system.data.dir', '/data');
INSERT INTO OZ_CFG_CONFIG(ID,CFG_KEY, CFG_VALUE) VALUES(hibernate_sequence.NEXTVAL,'system.cache.cluster.support.policy', 'false');
INSERT INTO OZ_CFG_CONFIG(ID,CFG_KEY, CFG_VALUE) VALUES(hibernate_sequence.NEXTVAL,'system.attachment.max.size', '20 MB');
INSERT INTO OZ_CFG_CONFIG(ID,CFG_KEY, CFG_VALUE) VALUES(hibernate_sequence.NEXTVAL,'user.password.confusion', 'false');
INSERT INTO OZ_CFG_CONFIG(ID,CFG_KEY, CFG_VALUE) VALUES(hibernate_sequence.NEXTVAL,'user.password.validity.days', '90');
INSERT INTO OZ_CFG_CONFIG(ID,CFG_KEY, CFG_VALUE) VALUES(hibernate_sequence.NEXTVAL,'user.password.max.locked.times', '-1');
INSERT INTO OZ_CFG_CONFIG(ID,CFG_KEY, CFG_VALUE) VALUES(hibernate_sequence.NEXTVAL,'user.password.max.locked.hours', '4');
INSERT INTO OZ_CFG_CONFIG(ID,CFG_KEY, CFG_VALUE) VALUES(hibernate_sequence.NEXTVAL,'system.web.app.path', 'http://localhost:8080/ems/');
INSERT INTO OZ_CFG_CONFIG(ID,CFG_KEY, CFG_VALUE) VALUES(hibernate_sequence.NEXTVAL,'system.webui.toolbar.useBtnBack', '1');
select * from OZ_CFG_CONFIG;

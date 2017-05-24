/*
 * Copyright (c) 2010 - OZ Wizards Group.
 * 
 * All rights reserved.
 * 
 * Created on 2010-8-8
 */
package cn.suntak.ems.filenumber.domain;

import java.util.Date;

import cn.oz.FileEntity;
import cn.oz.SourceFile;

/**
 * 文件编号信息
 * 
 * @author yanxuehui
 * @version 5.2.0
 */
public class FileNumber extends FileEntity {
	// constants ==============================================================
		/**
		 * 按年编号
		 */
		public static final int STATUS_YEAR = 0;
		/**
		 * 按月编号
		 */
		public static final int STATUS_MONTH = 1;
		/**
		 * 按天编号
		 */
		public static final int STATUS_DAY = 2;
		/**
		 * 永久（不断号）
		 */
		public static final int STATUS_FOREVER = 3;

		// fields =================================================================
		private String numberName; 								// 编号名称
		private String numberCode; 								// 编号代码
		private String numberPrefix; 							// 编号前缀
		private String numberPostfix; 							// 编号后缀
		private String serial;									// 序列
		private int numberRule = STATUS_YEAR; 					// 编号规则
		private Date numberDate;								// 信息更新时间，用来判定是否使用时间
		private int numberLength;								// 信息更新时间，用来判定是否使用时间
		private String unitId; 									// 该编号所属单位的Id
		private String numberOrder;								//排序号
		private int status;

	// constructor ============================================================
	public String toString() {
		String fileNumber = String.valueOf(this.getId()) + "--";
		fileNumber += this.getNumberName() + "(" + String.valueOf(this.getNumberCode()) + ")" + String.valueOf(this.getSerial());
		
		return fileNumber;
	}


	// getters/setters ========================================================
	public String getNumberName() {
		return numberName;
	}

	public void setNumberName(String numberName) {
		this.numberName = numberName;
	}

	public String getNumberCode() {
		return numberCode;
	}

	public void setNumberCode(String numberCode) {
		this.numberCode = numberCode;
	}

	public String getNumberPrefix() {
		return numberPrefix;
	}

	public void setNumberPrefix(String numberPrefix) {
		this.numberPrefix = numberPrefix;
	}

	public String getNumberPostfix() {
		return numberPostfix;
	}

	public void setNumberPostfix(String numberPostfix) {
		this.numberPostfix = numberPostfix;
	}

	public String getSerial() {
		return serial;
	}

	public void setSerial(String serial) {
		this.serial = serial;
	}

	public int getNumberRule() {
		return numberRule;
	}

	public void setNumberRule(int numberRule) {
		this.numberRule = numberRule;
	}

	public Date getNumberDate() {
		return numberDate;
	}

	public void setNumberDate(Date numberDate) {
		this.numberDate = numberDate;
	}

	public String getUnitId() {
		return unitId;
	}

	public void setUnitId(String unitId) {
		this.unitId = unitId;
	}


	public int getNumberLength() {
		return numberLength;
	}


	public void setNumberLength(int numberLength) {
		this.numberLength = numberLength;
	}


	public String getNumberOrder() {
		return numberOrder;
	}


	public void setNumberOrder(String numberOrder) {
		this.numberOrder = numberOrder;
	}


	public int getStatus() {
		return status;
	}


	public void setStatus(int status) {
		this.status = status;
	}

	
}
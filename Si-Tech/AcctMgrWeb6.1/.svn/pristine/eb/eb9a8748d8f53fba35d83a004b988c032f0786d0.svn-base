package com.sitech.acctmgr.test.atom.entity;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import org.junit.Test;

import com.sitech.common.utils.PrivacyUtil;
import com.sitech.jcfx.util.CodecUtil;

public class IdIccidEnc {
	public static void main(String[] args) throws UnsupportedEncodingException, IOException {
		// 客户名称解密
		String custname = new String(CodecUtil.decodeBASE64("e8c76a2210a8a1d89e9189d325433944gqT"), "GB18030");
		System.out.println("客户名称解密后：" + custname);
		
		// 证件ID解密
		// String idiccid = new String(CodecUtil.decodeBASE64("e8c76a2210a8a1d89e9189d325433944gqT"), "UTF-8");
		// System.err.println("证件ID解密后：" + idiccid);

	}

	@Test
	public void test(){
		String inName = "29829888";
		String aa = PrivacyUtil.encode(inName);
		System.err.println(aa);
	}
}

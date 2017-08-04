<%
/********************
 version v2.0
 ¿ª·¢ÉÌ si-tech
 update zhangyan@2013/10/14 17:33:50
********************/
%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="sitech.www.frame.util.DataSourceUtils" %>
<%@ page import="sitech.www.frame.util.DataAccessException" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="javax.sql.DataSource" %>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %> 
<%@ page contentType="text/html; charset=GB2312" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%

String svcName = request.getParameter( "svcName" );
String outNum = request.getParameter( "outNum" ) ;

int inNum = Integer.parseInt ( request.getParameter( "inNum" ) );

String inParams [] = new String [inNum];
String regCode = ( String )session.getAttribute( "regCode" );

int outPos = Integer.parseInt( request.getParameter( "outPos" ) );
%>
<wtc:service name="<%=svcName%>" outnum="<%=outNum%>" routerKey="region" 
	routerValue="<%=regCode%>" retcode="retCode" retmsg="retMsg">
	<%
	for(int i = 0; i < inParams.length; i++)
	{
		inParams[i] = request.getParameter("param" + i);
	%>
		<wtc:param value="<%=inParams[i]%>"/>
	<%
	}
	%>
</wtc:service>
<wtc:array id="result" scope="end"/>
<%
String photo = result[0][outPos];
if ( photo.equals("") )
{
	photo = 
		"/9j/4AAQSkZJRgABAQEAYABgAAD/2wBDAAMCAgMCAgMDAwMEAwMEBQgFBQQEBQoHBwYIDAoMDAsK"+
		"CwsNDhIQDQ4RDgsLEBYQERMUFRUVDA8XGBYUGBIUFRT/2wBDAQMEBAUEBQkFBQkUDQsNFBQUFBQU"+
		"FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBT/wAARCABcAFADASIA"+
		"AhEBAxEB/8QAHwAAAQUBAQEBAQEAAAAAAAAAAAECAwQFBgcICQoL/8QAtRAAAgEDAwIEAwUFBAQA"+
		"AAF9AQIDAAQRBRIhMUEGE1FhByJxFDKBkaEII0KxwRVS0fAkM2JyggkKFhcYGRolJicoKSo0NTY3"+
		"ODk6Q0RFRkdISUpTVFVWV1hZWmNkZWZnaGlqc3R1dnd4eXqDhIWGh4iJipKTlJWWl5iZmqKjpKWm"+
		"p6ipqrKztLW2t7i5usLDxMXGx8jJytLT1NXW19jZ2uHi4+Tl5ufo6erx8vP09fb3+Pn6/8QAHwEA"+
		"AwEBAQEBAQEBAQAAAAAAAAECAwQFBgcICQoL/8QAtREAAgECBAQDBAcFBAQAAQJ3AAECAxEEBSEx"+
		"BhJBUQdhcRMiMoEIFEKRobHBCSMzUvAVYnLRChYkNOEl8RcYGRomJygpKjU2Nzg5OkNERUZHSElK"+
		"U1RVVldYWVpjZGVmZ2hpanN0dXZ3eHl6goOEhYaHiImKkpOUlZaXmJmaoqOkpaanqKmqsrO0tba3"+
		"uLm6wsPExcbHyMnK0tPU1dbX2Nna4uPk5ebn6Onq8vP09fb3+Pn6/9oADAMBAAIRAxEAPwD9I9lG"+
		"ypdvtRt9q7TyrEWyjZUu32o2+1AWItlGypdvtRt9qAsRbKNlS7fajb7UBYi2UbKl2+1G32oCxNsF"+
		"GwVNto21BpYh2CsLxB4jTSm+z26rNdkZYMfljHq2O/oP5VtaneJpmnXV5JykETSEDvgZxXkVzPLO"+
		"X81t0rsXmYfxOeW/DPAHoK+M4lzuWVUYwo/xJ7eS7n0OUZdHGTc6nwr8Wbdlcal4m1EWcV/NJOVL"+
		"HZKYI1A68pz39zVKHxRqWk3Uka3Ukhjco8V0fNQkHB+b7w6ev4VqfDFkh8VFScGS1kRc9zuQ/wAg"+
		"a5vV7iCfWdRkV8q91MwPqDIxFfmdbH4ylgKWPjXkqkpyT1eytb+vM+whh6M608PKmuVJPbvc9L8O"+
		"+IrbxFC5jBhuIv8AWQOclc9CD3B9a19gryLRNSbRNXtbtHIi3hJRnhoycNn6feHuK9j21+qcN5xL"+
		"OMI51f4kXaX6P5/mfFZtgI4GsvZ/DLb9UQ7BRsFTbaNtfVnh2J9lGypdvtRt9qk1sYHjO2efwrqq"+
		"xgs4t2YAd8DOP0rxM6hKrsARjJNfRbRhgQQCDwQa8M8Y+FJfDmqtGsbfZJTm2kPIYf3M/wB4encD"+
		"PrX5bxtgatSNPGU1dR0fl2f9eR9tw7iKcefDz3eq/UZ4O1mLSPFNhfXkrpbxlxKyqWwDGwHA5PJF"+
		"YSM4Rd7Evj5iT1Pet/wTe6NY64X12FJLPyWUCWEyqHyuCVAOeNw6HrWRfvDcahdGzjK2zTOYUI5V"+
		"Nx2j8sV+ZVYyeX0k5p+9J8v2ldR1flpp8/l9hFpYiT5WtFr00b289dfkRRebdN9mQktL+7Uf7TfK"+
		"P1Ir6L2V5d8NfB8l3eQ6tcJi0hO6Ld/y0fsR7Drnucelerbfav13gzL6mEwk61VW9o1ZeS2fzuz4"+
		"XiHEwr1o0ofZvf1dtPwItlGypdvtRt9q/Qj5OxJto207bRtqS7Ddtc54otNSvbSWCCCG4hcYKSrk"+
		"H610uKXaalpSVmUrxd0fPOpeEfF0U5+z6XE0eeFJzj8Tk/rV7w/4N8SvcK19pcDJnOx/u/QgYB/H"+
		"Ne77aXy29K8aOS5bGp7VUI39P02PReY4tx5HUdv667mZo6XiW6rdKiYAAVBjA9K0NtP2Gjaa9o80"+
		"Zto207bRtpisLupQwyKr+ZR5lAzwG7u9RsNUntJF1K0ZpY1vJZJpnkBADHeYbx9+1Cg53MVwAAea"+
		"6vQILuLw8Z9N0SPXLK5uZHY2d1LpzIY2Zd8pmnZ23A52nG0qd2TjGnr3wb0vxFrd9qdzqN9FLdSC"+
		"Qxwx25VcIq4BeJj/AA5696tp8NYovDdr4eTV7xNFWSVryGNUjkvEZtwiZ1A2JyQwQAsOMgEg/n+F"+
		"yWvQq1LwvH3uXWLestN7rVN3vF/fY+4r5jhatKFp+9pzK0rba7Wd07Ws191zmfCmu6jqjNPY+FJt"+
		"RkhlWYNB4hA8pWO+NSGf5htxyRhh7Vw1rJpL2wk8rQJLdGt958wJGHMTsFZ5HRQflJcbgSQFBGcj"+
		"17xF8MbfX7q+A1S6sdL1BYVvtNghhMcyxABAGZCyDCgcGrcfgC3t4o0t9W1W38uK2RSlyWw8LErJ"+
		"82eSCQV+4QeVJwRlLIcRNQg9oX1tD3r6aJJbpK/M3+GtQzTCQ5pp6ytp72ne7d+t7cq/F6cKt7Zn"+
		"4eaRPp0dvBJba+Hjkjt2uoBMqu+6OOF2ZkxwArkkZOea1/BV9q+p+LLy5t9W0p7y4EEmpxS6Be2j"+
		"PAhZV8rzXXacFhk7xnnAHFdNp3gKz0/W7LUft1/dCyNwbW2uZQ8cLTEbmBxuYgAqC7MQGOMVrJo0"+
		"SeJp9a82Qzy2cdl5XGwKkkj7vXJMmPwr1cNlWIpzpym7KLWiv0ha+jtvpaz0166edXzDDyhOMNW0"+
		"3dpbuV7aq+2u6V/x2d1G6oPMo8yvsD5Yo/avpR9q+lQeWPejyx71djLmJ/tX0o+1fSoPLHvR5Y96"+
		"LBzE/wBq+lH2r6VB5Y96PLHvRYOYn+1fSj7V9Kg8se9Hlj3osHMT/avpR9q+lQeWPejyx70WDmP/"+
		"2Q==";
}

photo = photo.replaceAll( " " , "+" );
System.out.println( "zhangyan ~~~"+ photo );
OutputStream os=null;
response.reset();
response.setContentType("image/jpeg");
os = response.getOutputStream();
byte[] b_photo = new sun.misc.BASE64Decoder().decodeBuffer(new String(photo));
os.write(b_photo);
os.flush();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.util.*"%>
<%@ page import="com.sitech.crmpd.core.wtc.WtcUtil"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>
<%
response.setHeader("Pragma","No-cache");
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", 0);
%>
<%
//String themePath = (String)session.getAttribute("themePath");/modify by qidp for HLJ @ 2010-04-29
String themePath = (String)session.getAttribute("themePath");
String layout = (String)session.getAttribute("layout");

/**  modified by hejwa in 20110714 ��OP����--���������ø���  begin **/ 
String regionCode = (String)session.getAttribute("regCode");
String  powerCode = session.getAttribute("powerCode")==null?"":((String)session.getAttribute("powerCode")).trim();//��ɫ����
String workNo = (String)session.getAttribute("workNo");
/**  modified by hejwa in 20110714 ��OP����--���������ø���  end **/ 

%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<title>��������</title>
	<link href="<%=request.getContextPath()%>/nresources/<%=themePath%>/css/set.css" rel="stylesheet" type="text/css" />
	<script src="<%=request.getContextPath()%>/njs/system/jquery-1.3.2.min.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/njs/redialog/redialog.js" type="text/javascript"></script>
	<script src="<%=request.getContextPath()%>/njs/system/system.js" type="text/javascript"></script>
</head>

<body>

<div class="popup_600">
	<div id="operation_table">
		<div class="title">
			<div class="text">
				��������</div>
		</div>
		<div class="set_content">
			<div class="tit">
				���ѡ��</div>
			<div class="iconc">
				<!--
					<div class="li theme_5">
					  <div class="pic"></div>
					  <div class="ico_text"><input name="Radio1" value="1" type="radio" <% if("1".equals(layout)){out.print(" checked ");} %> />���������</div>
					</div>
					<div class="li theme_1">
					  <div class="pic"></div>
					  <div class="ico_text"><input name="Radio1" value="2" type="radio" <% if("2".equals(layout)){out.print(" checked ");} %> />��ʾȫ��</div>
					</div>
					<div class="li theme_7">
					  <div class="pic"></div>
					  <div class="ico_text"><input name="Radio1" value="3" type="radio" <% if("3".equals(layout)){out.print(" checked ");} %> />�޲˵�</div>
					</div>
					<div class="li theme_3">
					  <div class="pic"></div>
					  <div class="ico_text"><input name="Radio1" value="4" type="radio" <% if("4".equals(layout)){out.print(" checked ");} %> />����</div>
					</div>
					-->
			<%-- /**  modified by hejwa 20110714 ��OP����--���������ø���  begin **/ --%>
				<%
				String reLayoutArrl[][] = new String[][]{
										  {"0","���������","1","0"},
  										  {"1","��ʾȫ��","1","1"},
  										  {"2","�޲˵�","1","0"},
  										  {"3","����","1","0"}
  										};//û�����ù���̨��ɫ�Ĺ��Ž���Ĭ������
  										
					String layout_sql = "select a.layout_css, a.layout_name, a.is_effect, b.is_default "+
										" from dlayoutmsg a, dlayoutrole_rel b "+
										" where  a.layout_css = b.layout_css and b.op_role=(select trim(h.m_rolecode) from dmoprolerela h where h.b_rolecode=:powerCode)    "+
										"order by a.layout_css";
					String layout_param = "powerCode="+powerCode.trim();
				%>
				
				<wtc:service name="TlsPubSelCrm" outnum="4" routerKey="region" routerValue="<%=regionCode %>">
					<wtc:param value="<%=layout_sql%>" />
					<wtc:param value="<%=layout_param%>" />
				</wtc:service>
				<wtc:array id="layoutList" scope="end"/>
				<%				
			if("000000".equals(retCode)){ 	
				 
				if(layoutList.length==0){
					layoutList = reLayoutArrl;
				}
				for(int i=0;i<layoutList.length;i++){
					String jsParam = "0";
					String layoutStyle = "li theme_1"; //Ĭ��Ϊ��ʾȫ������ʽ
					
					String layout_css = layoutList[i][0];
					String layout_name = layoutList[i][1];
					String is_effect = layoutList[i][2];
					String is_default = layoutList[i][3];
			 	
					if("0".equals(layout_css)){	
						layoutStyle = "li theme_6";
					}else if("1".equals(layoutList[i][0])){
						layoutStyle = "li theme_1";
					}else if("2".equals(layoutList[i][0])){
						layoutStyle = "li theme_7";
					}else if("3".equals(layoutList[i][0])){
						layoutStyle = "li theme_4";
					}						
					
					%>
						<div class="<%=layoutStyle%>">
						  <div class="pic"></div>
						  <div class="ico_text"><input name="Radio1" type="radio" value="<%=layout_css%>" <%if(layout.trim().equals(layout_css.trim())){%>checked="checked"<%}%> /><%=layout_name%></div>
						</div>
					<%
				}
			}else{//�������ִ��ʧ��,Ĭ�ϡ���ʾȫ����
				%>
				<div class="li theme_1">
				  <div class="pic"></div>
				  <div class="ico_text"><input name="Radio1" type="radio" value="0" checked="checked" />��ʾȫ��</div>
				</div>				
			<%
			}
			%>	
			
			<%-- /**  modified by hejwa 20110714 ��OP����--���������ø���  end **/ --%>
					
				<div class="clr"></div>
			</div>
			<div class="tit">
				���ѡ��</div>
			<div class="iconc">
	<!--
					<div class="li pic_1">
					  <div class="pic"></div>
					  <div class="ico_text"><input name="Radio2" type="radio" value="default" <% if("default".equals(themePath)){out.print(" checked ");} %> />������ɫ</div>
					</div>
					<div class="li pic_2">
					  <div class="pic"></div>
					  <div class="ico_text"><input name="Radio2" type="radio" value="orange" <% if("orange".equals(themePath)){out.print(" checked ");} %> />���ó�ɫ</div>
					</div>
-->
<%-- /**  modified by hejwa 20110714 ��OP����--���������ø���  begin **/ --%>
				<%
					String themeListArr[][] = new String[][]{{"default","������","1","1"},
  										  {"orange","���ó�","1","0"}
  										};//û�����ù���̨��ɫ�Ĺ��Ž���Ĭ������
					String theme_sql = "select a.theme_css, a.theme_name, a.is_effect, b.is_default from dthememsg a, dthemerole_rel b  where  a.theme_css = b.theme_css and b.op_role=(select trim(h.m_rolecode) from dmoprolerela h where h.b_rolecode=:powerCode)   order by a.theme_css";
					String theme_param = "powerCode="+powerCode.trim();
				%>
				
				<wtc:service name="TlsPubSelCrm" outnum="4" routerKey="region" routerValue="<%=regionCode %>">
					<wtc:param value="<%=theme_sql%>" />
					<wtc:param value="<%=theme_param%>" />
				</wtc:service>
				<wtc:array id="themeList" scope="end"/>
				<%				
			if("000000".equals(retCode)){ 	
				 
				if(themeList.length==0){
					themeList = themeListArr;
				}
				System.out.println("-------themeList.length---------"+themeList.length);
				for(int i=0;i<themeList.length;i++){
				
					String jsParam = "0";
					String themeStyle = "li pic_1"; //Ĭ��Ϊȫ��ͨ����ʽ
					
					String theme_css = themeList[i][0];
					String theme_name = themeList[i][1];
					String is_effect = themeList[i][2];
					String is_default = themeList[i][3];
			System.out.println("---------theme_name-----------"+theme_name);
					if("default".equals(theme_css)){	
						themeStyle = "li pic_1";
					}else if("GUI".equals(theme_css)){
						themeStyle = "li pic_2";
					}else if("orange".equals(theme_css)){
						themeStyle = "li pic_3";
					}					
					%>
					<div class="<%=themeStyle%>">
					  <div class="pic"></div>
					  <div class="ico_text"><input name="Radio2" type="radio" value="<%=theme_css%>" <%if(themePath.trim().equals(theme_css)){%>checked="checked"<%}%> /><%=theme_name%></div>
					</div>
					<%
				}
			}else{//�������ִ��ʧ��,Ĭ��Ϊ����������ʽ
				%>
				<div class="li pic_1">
				  <div class="pic"></div>
				  <div class="ico_text"><input name="Radio2" type="radio" value="default" checked="checked" />������</div>
				</div>				
			<%
			}
			%>	
			
			<%-- /**  modified by hejwa 20110714 ��OP����--���������ø���  end **/ --%>
			
				<div class="clr"></div>

			</div>
			<!-- 
			<div class="iconc">
				���б�ɫ��<input type="radio" name="" value="">���� <input type="radio" name="" value="">�ر�
				</br>
				�Ҽ����䣺<input type="radio" name="" value="">���� <input type="radio" name="" value="">�ر�
				</br>
				��ݼ�:<input type="radio" name="" value="">���� <input type="radio" name="" value="">�ر�
				</br>
			</div>
			-->
			<%-- /**  modified by hejwa 20110714 ��OP����--���������ø���  begin **/ --%>
				<%
				String wkSql = "select to_char(open_max),to_char(is_commu) from dwkspace where login_no=:login_no";
				String wkParams="login_no="+workNo;
				
				%>
				<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
				  	<wtc:param value="<%=wkSql%>"/>
				  	<wtc:param value="<%=wkParams%>"/>
				</wtc:service>
				<wtc:array id="wkResult" scope="end"/>
				<%
				String tabSelected = "10";
				String wkchecked = "0"; 
				if("000000".equals(retCode)){
					if(wkResult.length>0){
				
							tabSelected = wkResult[0][0].trim();
							wkchecked = wkResult[0][1].trim();

							if("".equals(tabSelected)){//Ϊ���ַ���ʱ��Ĭ��Ϊ10
								tabSelected = "10";
							}
							if("".equals(wkchecked)){//Ϊ���ַ���ʱ��Ĭ��Ϊ0��δ����
								wkchecked = "0";
							}
					}			
				}
				
				%>
			<div class="tit">
						����ҳ��������
						<select id="tabNum" name="tabNum">
									  <option value="6" <%if("6".equals(tabSelected)){%>selected<%}%> >
											6
										</option>	
										<option value="8" <%if("8".equals(tabSelected)){%>selected<%}%>>
											8
										</option>		
										<option value="10" <%if("10".equals(tabSelected)){%>selected<%}%>>
											10
										</option>		
										<option value="12" <%if("12".equals(tabSelected)){%>selected<%}%>>
											12
										</option>		
										<option value="14" <%if("14".equals(tabSelected)){%>selected<%}%>>
											14
										</option>										
						</select>
			</div>
		
			<div class="tit">
						������ͨѶ��<input type="radio" id="rightkey" name="rightkey" value="1" <%if("1".equals(wkchecked)){%>checked<%}%>>����  <input type="radio" id="rightkey" name="rightkey" value="0" <%if("0".equals(wkchecked)){%>checked<%}%>>�ر�						
			</div>
			<%-- /**  modified by hejwa 20110714 ��OP����--���������ø���  end **/ --%>
		</div>
		<div id="but_bg">
			<input class="but" type="button" value="����" onclick="save()" />
			<input class="but" type="button" value="ȡ��" onclick="window.close()"/>
		</div>
		<input type="hidden"  id="skinTypeInSession" name="skinTypeInSession" value="<%=themePath%>"/>
		<input type="hidden"  id="layoutInSession"   name="layoutInSession"   value="<%=layout%>"/>
	</div>
<!--
<OBJECT ID="AddBarLimitCtrl" CLASSID="CLSID:F75FB9B2-C75A-4953-9663-CCA5AF1F79EB" CODEBASE="/ocx/IELimit.dll" style="DISPLAY: none"></OBJECT>
-->
</body>
<script type="text/javascript">
    function save(){
        vLayout = getRadiosVal(document.all.Radio1);
        vTheme = getRadiosVal(document.all.Radio2);
        changeSubmit(vTheme,vLayout);
    }
    
    //ȡradio valueֵ
    function getRadiosVal(obj){
    		var theRadioLen = obj.length;
    		var theRadioValue = false;
    		if(theRadioLen == undefined){
    			if(obj.checked){
    				theRadioValue = obj.value;
    			}
    		}else{
    			for (var i=0;i<theRadioLen;i++){
    				if (obj[i].checked){
    					theRadioValue = obj[i].value;
    					break;
    				}
    			}
    		}
    		return theRadioValue;
    }

    function changeColor(skinType,layout){
		changeSubmit(skinType,layout);
	}

	function changeSubmit(skinType,layout)
	{
	//alert("skinType|"+skinType+"\nlayout|"+layout);	
		if(rdShowConfirmDialog("ȷ�ϸ���������")!=1){	
			return false;
		}
		var myPacket = new AJAXPacket("setThemeAjaxCfm.jsp","���ڱ���Ƥ����Ϣ�����Ժ�......");
 		myPacket.data.add("skinType",skinType);
 		myPacket.data.add("layout",layout);
 		<%-- /**  modified by hejwa in 20110714 ��OP����--���������ø���  begin **/ --%>
 		var tabNum = $('#tabNum').val();
		var rightkey = $('input[name=rightkey]:checked').val();
		myPacket.data.add("tabNum",tabNum);
		myPacket.data.add("rightkey",rightkey);
		
		<%-- /**  modified by hejwa in 20110714 ��OP����--���������ø���  end **/ --%>
		core.ajax.sendPacket(myPacket,changeSubmit_return);
	}
	
	function changeSubmit_return(packet)
	{
			var retCode = packet.data.findValueByName("retCode");
			var retMsg = packet.data.findValueByName("retMsg");
			
			if("000000"!=retCode){	
    			rdShowMessageDialog("["+retCode+"]:"+retMsg);
    			return false;
			}else{ 
                var skinType = packet.data.findValueByName("skinType");
                var layout = packet.data.findValueByName("layout");
                createCookie("skin_foryou",skinType,365);
                //alert(readCookie("skin_foryou"));
                document.getElementById("skinTypeInSession").value = skinType;
                document.getElementById("layoutInSession").value = layout;
                rdShowConfirmDialog("�����ɹ�����Ƥ���������´ε�½ʱ��Ч��",2);
                window.close();
                /*
                if(rdShowConfirmDialog("�����ɹ�! �Ƿ�����ˢ��ʹƤ����Ч?<br>�ò�����ˢ�����еĶ���,ע��ҳ�����ݵı���!")==1)
                {
                */
                    /*
                    var path =String(top_new.location);
                    if(path.indexOf("#")!=-1)
                    {
                    path = path.substr(0,path.length-1);
                    }
                    top_new.location=path;
                    */
                    /*
                    parent.location.reload();
                }
                */
 			}
	}
/*************************************/ 			
    //дCookie
	function createCookie(name,value,days)
	{
	    if (days)
	    {
	        var date = new Date();
	        date.setTime(date.getTime()+(days*24*60*60*1000));
	        var expires = "; expires="+date.toGMTString();
	    }
	    else var expires = "";
	    document.cookie = name+"="+value+expires+"; path=/";
	}
	
	//��Cookie
	function readCookie(name)
	{
	    var nameEQ = name + "=";
	    var ca = document.cookie.split(';');
	    for(var i=0;i < ca.length;i++)
	    {
	        var c = ca[i];
	        while (c.charAt(0)==' ') c = c.substring(1,c.length);
	        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
	    }
	    return null;
	}
	/*************************************/
		
</script>
</html>

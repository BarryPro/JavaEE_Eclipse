<%
/********************
 * version v2.0
 * ������: si-tech
 ********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>

	<%
    String workNo = (String)session.getAttribute("workNo");
		String regionCode= (String)session.getAttribute("regCode");
		String password = (String)session.getAttribute("password");
		String phoneNo = request.getParameter("phoneNo");
		String ptype = request.getParameter("ptype");
		String querysType = request.getParameter("querysType");
		String magicDJName="";
		String magicInnerName="";
		Date currentTime = new Date(); 
    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String currentTimeString = formatter.format(currentTime);

				String qtypes = request.getParameter("qtypes");
				String sele = request.getParameter("sele");
				
		if(querysType.equals("mofaquery")) {//�����ѯ��֯����
						if(qtypes.trim().equals("1")) {
						magicDJName = sele.trim();
						magicInnerName="";
						}
						if(qtypes.trim().equals("2")) {
						magicDJName = "";
						magicInnerName=sele.trim();
			    	}
		}

	%>

		<wtc:sequence name="sPubSelect" key="sMaxSysAccept" routerKey="regioncode" 
			routerValue="<%=regionCode%>"  id="loginAccept" />
			<%
			String  inputParsm [] = new String[17];
			inputParsm[0] = loginAccept;
			inputParsm[1] = "01";
			inputParsm[2] = "e217";
			inputParsm[3] = workNo;
			inputParsm[4] = password;
			inputParsm[5] = phoneNo;
			inputParsm[6] = "";
			inputParsm[7] = "ZY";
			inputParsm[8] = "045102";
			inputParsm[9] = "ZY0201";
			inputParsm[10] ="21";
			inputParsm[11] =currentTimeString;
			inputParsm[12] ="20501231235959";
			inputParsm[13] =currentTimeString;
			inputParsm[14] ="ħ�������в�ѯ";
			inputParsm[15] =magicDJName;
			inputParsm[16] =magicInnerName;
			
			for(int k = 0; k <= 16; k++ ){
				System.out.println("-------ningtn--------inputParsm[" + k + "] " + inputParsm[k]);
			}
		%>
			
<wtc:service name="sProWorkFlowCfm" routerKey="phone" routerValue="<%=phoneNo%>" retcode="retCode" retmsg="retMsg" outnum="4">
				<wtc:param value="<%=inputParsm[0]%>"/>
				<wtc:param value="<%=inputParsm[1]%>"/>
				<wtc:param value="<%=inputParsm[2]%>"/>
				<wtc:param value="<%=inputParsm[3]%>"/>
				<wtc:param value="<%=inputParsm[4]%>"/>
				<wtc:param value="<%=inputParsm[5]%>"/>
				<wtc:param value="<%=inputParsm[6]%>"/>
				<wtc:param value="<%=inputParsm[7]%>"/>
				<wtc:param value="<%=inputParsm[8]%>"/>
				<wtc:param value="<%=inputParsm[9]%>"/>
			  <wtc:param value="<%=inputParsm[10]%>"/>
				<wtc:param value="<%=inputParsm[11]%>"/>
				<wtc:param value="<%=inputParsm[12]%>"/>
				<wtc:param value="<%=inputParsm[13]%>"/>
				<wtc:param value="<%=inputParsm[14]%>"/>
				<wtc:param value="<%=inputParsm[15]%>"/>
				<wtc:param value="<%=inputParsm[16]%>"/>
	</wtc:service>

		<wtc:array id="result1" scope="end"  />
			<%

if("000000".equals(retCode)){
		System.out.println(" ======== sProWorkFlowCfm ���óɹ� ========"  + retCode + " | " + retMsg);
		System.out.println("--------xiaoxiao--------"+result1[0][0]);
		
		%>
<body>
          <%
					 if(querysType.equals("mofa")) {//������Ĭ�ϲ�ѯ��ʾ
					 %>
					 							<script language="javascript">
					 						//var data1="	{'mftoneboxs':{'mftonebox':[{'mftoneboxid':'2','mftoneboxname':'�¸��ٵ�2Ԫ��','tonebox':[{'toneboxname':'�乾����1Ԫ��','toneboxtype':'0','toneboxcode':'6009020059','tone':{'tonecode':'600902000008715706','tonename':'Home Sweet Home','singer':'������'}},{'toneboxname':'��������1Ԫ��','toneboxtype':'1','toneboxcode':'6009020006','tone':{'tonecode':'600902000008871745','tonename':'�ı�','singer':'����ӱ'}}],'price':'200'},{'mftoneboxid':'1','mftoneboxname':'��������3Ԫ��','tonebox':[{'toneboxname':'��������2Ԫ��','toneboxtype':'0','toneboxcode':'6009020060','tone':[{'tonecode':'600902000007896454','tonename':'лл','singer':'������'},{'tonecode':'600902000007890055','tonename':'������','singer':'��һ��'}]},{'toneboxname':'���о���1Ԫ3�����ֺ�','toneboxtype':'1','toneboxcode':'6009020176','tone':[{'tonecode':'600902000008875285','tonename':'����ʱ��','singer':'�ܻ���'},{'tonecode':'600902000008887917','tonename':'����','singer':'ë����'},{'tonecode':'600902000000028886','tonename':'��ϧ������','singer':'������'}]}],'price':'300'}],'mftoneboxtotalnum':'2'}}";
								  //var data1="{ 'mftoneboxs': { 'mftonebox': [{ 'mftoneboxid': '1', 'mftoneboxname': '��������3Ԫ��', 'tonebox': [ { 'toneboxname': '��������2Ԫ��',  'toneboxtype': '0', 'toneboxcode': '6009020060', 'tone': [  {'tonecode': '600902000007896454', 'tonename': 'лл','singer': '������' }, {  'tonecode': '600902000007890055',  'tonename': '������',  'singer': '��һ��'   }  ] }, { 'toneboxname': '���о���1Ԫ3�����ֺ�', 'toneboxtype': '1', 'toneboxcode': '6009020176', 'tone': [{ 'tonecode': '600902000008875285',  'tonename': '����ʱ��', 'singer': '�ܻ���' },  { 'tonecode': '600902000008887917', 'tonename': '����','singer': 'ë����' },{'tonecode': '600902000000028886', 'tonename': '��ϧ������', 'singer': '������'   }  ] } ], 'price': '300' }, { 'mftoneboxid': '2',  'mftoneboxname': '��������3Ԫ��222222222222', 'tonebox': [ {  'toneboxname': '��������2Ԫ��22222222222222', 'toneboxtype': '0','toneboxcode': '6009020060222', 'tone': [ {  'tonecode': '6009020000078964542222', 'tonename': 'лл222', 'singer': '������222' }, { 'tonecode': '6009020000078900552222', 'tonename': '������22222',  'singer': '��һ��222222' } ] },{'toneboxname': '���о���1Ԫ3�����ֺ�2222222', 'toneboxtype': '1', 'toneboxcode': '6009020176222', 'tone': [  { 'tonecode': '6009020000088752852222', 'tonename': '����ʱ��222222','singer': '�ܻ���222222' },{'tonecode': '6009020000088879172222', 'tonename': '����2222222','singer': 'ë����222222222'},{'tonecode': '6009020000000288862222','tonename': '��ϧ������222222222','singer': '������22222222222222' } ]}],'price': '300'}],'mftoneboxtotalnum': '2'}}"; 
                  //var data1="{ 'mftoneboxs':{'mftonebox':{'mftoneboxid':'1','mftoneboxname':'��������3Ԫ��','tonebox':[{'toneboxname':'��������2Ԫ��','toneboxtype':'0','toneboxcode':'6009020060','tone':[{'tonecode':'600902000007896454','tonename':'лл','singer':'������'},{'tonecode':'600902000007890055','tonename':'������','singer':'��һ��'}]},{'toneboxname':'���о���1Ԫ3�����ֺ�','toneboxtype':'1','toneboxcode':'6009020176','tone':[{'tonecode':'600902000008875285','tonename':'����ʱ��','singer':'�ܻ���'},{'tonecode':'600902000008887917','tonename':'����','singer':'ë����'},{'tonecode':'600902000000028886','tonename':'��ϧ������','singer':'������'}]}],'price':'300'},'mftoneboxtotalnum':'1'}}";
                  var data1="<%=result1[0][0]%>";
							   //var data1="";
							   //alert(data1.length);
									if(data1.length>0 && data1.length>180) {


								//ת��Ϊjson���� 
								var dataObj=eval("("+data1+")");
								var snums ="";
								var type1s="";
								var type2s=""
								var type3s="";
								var type4s="";
								var zhujiao="���У�";
								var beijiao="���У�"
								var zhubeijiao1="";
								var zhujiaode1="";
								var zhujiaoname1="";
								var zhujiaoname3="";
								var zhujiaolingyinname1="";
								var zhujiaolingyincode1="";
								var zhujiaolingyincode3="";
								var zhubeijiao2="";
								var zhujiaode2="";
								var zhujiaoname2="";
								var zhujiaolingyinname2="";
								var zhujiaolingyincode2="";
								var zhubeijiao3="";
								var zhujiaolingyinname3="";
								var zhujiaoname4="";
								var zhujiaolingyincode4="";
								var zhujiaolingyinname4="";
								var zhubeijiao4="";
								
									$.each(dataObj.mftoneboxs,function(idx,item){ 
										//alert(idx+"-----"+item);
										if(idx=="mftoneboxtotalnum") {
											snums=item;
										}
										else {
											return;
										}
	}); 
	
			$.each(dataObj.mftoneboxs,function(idx,item){ 
				//alert(idx+"-----"+item);
										if(idx=="mftonebox") {
									
										}
										else {
											return;
										}
												if(snums=="1") {
											 if(typeof(item.tonebox)=="object") {
                     type1s =item.tonebox[0].toneboxtype;
                     zhujiaoname1=item.tonebox[0].toneboxname;
                     //zhujiaolingyinname1 =item.tonebox[0].toneboxtype;
                     zhujiaolingyincode1 =item.tonebox[0].toneboxcode;
                     var leths1 =item.tonebox[0].tone.length;
                      if(leths1==undefined) {
										 zhujiaolingyinname1+=" "+item.tonebox[0].tone.tonename+"--"+item.tonebox[0].tone.singer+"��";
                     	}
                     	else {
                     for(var i=0;i<leths1;i++) {
                     zhujiaolingyinname1 +=" "+item.tonebox[0].tone[i].tonename+"--"+item.tonebox[0].tone[i].singer+"��"; 
                    }
                     }
											type2s =item.tonebox[1].toneboxtype;
                     zhujiaoname2=item.tonebox[1].toneboxname;
                     //zhujiaolingyinname1 =item.tonebox[0].toneboxtype;
                     zhujiaolingyincode2 =item.tonebox[1].toneboxcode;
                     var leths2 =item.tonebox[1].tone.length;
                      if(leths2==undefined) {
										 zhujiaolingyinname2+=" "+item.tonebox[1].tone.tonename+"--"+item.tonebox[1].tone.singer+"��";
                     	}
                     	else {
                     for(var i=0;i<leths2;i++) {
                     zhujiaolingyinname2 +=" "+item.tonebox[1].tone[i].tonename+"--"+item.tonebox[1].tone[i].singer+"��"; 
                     }
                     }
                     if(type1s=="0") {
                     		zhubeijiao1="���У�"
                     }
                     if(type2s=="1") {
                     		zhubeijiao2=" ���У�"
                     }
 
                     	}
                     else if(typeof(item.tonebox)=="string"){
		                 }else {
		                 	}
											 $("#ssss").append("<tr><td width='4%'><input type='radio' name='lingyinheradio' value="+item.mftoneboxid+'|'+item.price+"></td><td width='8%'>"+item.mftoneboxid+"</td><td width='17%'>"+item.mftoneboxname+"</td><td width='8%'>"+item.price+"</td><td><strong>"+zhubeijiao1+"</strong>"+zhujiaolingyincode1+" "+zhujiaoname1+" "+zhujiaolingyinname1+"<br/>&nbsp;<strong>"+zhubeijiao2+"</strong>"+zhujiaolingyincode2+" "+zhujiaoname2+" "+zhujiaolingyinname2+"</td></tr>");
										}
										else {
											//alert(typeof(item[0].mftoneboxid));
										for(var is=0;is<snums;is++) {
											//alert(snums);
												//alert(item[is].mftoneboxid);
												//alert(item[is].mftoneboxname);
											type3s =item[is].tonebox[0].toneboxtype;

                     zhujiaoname3=item[is].tonebox[0].toneboxname;
                     //zhujiaolingyinname1 =item.tonebox[0].toneboxtype;
                     zhujiaolingyincode3 =item[is].tonebox[0].toneboxcode;
               
                     //alert(typeof(item[is].tonebox[0].tone));
                     var leths1 =item[is].tonebox[0].tone.length;
                     if(leths1==undefined) {

										 zhujiaolingyinname3+=" "+item[is].tonebox[0].tone.tonename+"--"+item[is].tonebox[0].tone.singer+"��";
                     	}
                     else {
                     for(var i=0;i<leths1;i++) {
                     zhujiaolingyinname3 +=" "+item[is].tonebox[0].tone[i].tonename+"--"+item[is].tonebox[0].tone[i].singer+"��"; 
                     //alert(zhujiaolingyinname3);
                    }
                     }
                    type4s =item[is].tonebox[1].toneboxtype;
                     zhujiaoname4=item[is].tonebox[1].toneboxname;
                     //zhujiaolingyinname1 =item.tonebox[0].toneboxtype;
                     zhujiaolingyincode4 =item[is].tonebox[1].toneboxcode;
                     var leths2 =item[is].tonebox[1].tone.length;
                     if(leths2==undefined) {
										 zhujiaolingyinname4+=" "+item[is].tonebox[1].tone.tonename+"--"+item[is].tonebox[1].tone.singer+"��";
                     	}
                     	else {
                     for(var i=0;i<leths2;i++) {
                     zhujiaolingyinname4 +=" "+item[is].tonebox[1].tone[i].tonename+"--"+item[is].tonebox[1].tone[i].singer+"��"; 
                    }
                     }
										if(type3s=="0") {
                     		zhubeijiao3="���У�"
                     }
                     if(type4s=="1") {
                     		zhubeijiao4=" ���У�"
                     }
												$("#ssss").append("<tr><td width='4%'><input type='radio' name='lingyinheradio' value="+item[is].mftoneboxid+'|'+item[is].price+"  ></td><td width='8%'>"+item[is].mftoneboxid+"</td><td width='17%'>"+item[is].mftoneboxname+"</td><td width='8%'>"+item[is].price+"</td><td><strong>"+zhubeijiao3+"</strong>"+zhujiaolingyincode3+" "+zhujiaoname3+" "+zhujiaolingyinname3+"<br/>&nbsp;<strong>"+zhubeijiao4+"</strong>"+zhujiaolingyincode4+" "+zhujiaoname4+" "+zhujiaolingyinname4+"</td></tr>");
												zhujiaolingyinname3="";
												zhujiaolingyinname4="";
										}
										}
				}); 		
			}		
			if(data1.length>0 && data1.length<180) {
					var dataObj=eval("("+data1+")"); 
			rdShowMessageDialog(dataObj.returncode,0);
	
			}
			
					
		</script>
								<table id="ssss" name="lingyinhe11" >
							<tr id="lingyinhetr">
								<th></th>
								<th>ħ�������б��</th>
								<th>ħ������������</th>
								<th>�۸�(��)</th>
								<th>��ע</th>
							
							</tr>
									</table>
					

				<%
					}
					%>
					          <%
					 if(querysType.equals("mofaquery")) {//�����������ѯ��ʾ
					 %>
					 							<script language="javascript">
								  //var data1="{ 'mftoneboxs': { 'mftonebox': [{ 'mftoneboxid': '1', 'mftoneboxname': '��������3Ԫ��', 'tonebox': [ { 'toneboxname': '��������2Ԫ��',  'toneboxtype': '0', 'toneboxcode': '6009020060', 'tone': [  {'tonecode': '600902000007896454', 'tonename': 'лл','singer': '������' }, {  'tonecode': '600902000007890055',  'tonename': '������',  'singer': '��һ��'   }  ] }, { 'toneboxname': '���о���1Ԫ3�����ֺ�', 'toneboxtype': '1', 'toneboxcode': '6009020176', 'tone': [{ 'tonecode': '600902000008875285',  'tonename': '����ʱ��', 'singer': '�ܻ���' },  { 'tonecode': '600902000008887917', 'tonename': '����','singer': 'ë����' },{'tonecode': '600902000000028886', 'tonename': '��ϧ������', 'singer': '������'   }  ] } ], 'price': '300' }, { 'mftoneboxid': '2',  'mftoneboxname': '��������3Ԫ��222222222222', 'tonebox': [ {  'toneboxname': '��������2Ԫ��22222222222222', 'toneboxtype': '0','toneboxcode': '6009020060222', 'tone': [ {  'tonecode': '6009020000078964542222', 'tonename': 'лл222', 'singer': '������222' }, { 'tonecode': '6009020000078900552222', 'tonename': '������22222',  'singer': '��һ��222222' } ] },{'toneboxname': '���о���1Ԫ3�����ֺ�2222222', 'toneboxtype': '1', 'toneboxcode': '6009020176222', 'tone': [  { 'tonecode': '6009020000088752852222', 'tonename': '����ʱ��222222','singer': '�ܻ���222222' },{'tonecode': '6009020000088879172222', 'tonename': '����2222222','singer': 'ë����222222222'},{'tonecode': '6009020000000288862222','tonename': '��ϧ������222222222','singer': '������22222222222222' } ]}],'price': '300'}],'mftoneboxtotalnum': '2'}}"; 
                  //var data1="{ 'mftoneboxs':{'mftonebox':{'mftoneboxid':'1','mftoneboxname':'��������3Ԫ��','tonebox':[{'toneboxname':'��������2Ԫ��','toneboxtype':'0','toneboxcode':'6009020060','tone':[{'tonecode':'600902000007896454','tonename':'лл','singer':'������'},{'tonecode':'600902000007890055','tonename':'������','singer':'��һ��'}]},{'toneboxname':'���о���1Ԫ3�����ֺ�','toneboxtype':'1','toneboxcode':'6009020176','tone':[{'tonecode':'600902000008875285','tonename':'����ʱ��','singer':'�ܻ���'},{'tonecode':'600902000008887917','tonename':'����','singer':'ë����'},{'tonecode':'600902000000028886','tonename':'��ϧ������','singer':'������'}]}],'price':'300'},'mftoneboxtotalnum':'1'}}";
                  var data1="<%=result1[0][0]%>";
							   //var data1="";
							  // alert(data1.length);
								if(data1.length>0 && data1.length>180) {


								//ת��Ϊjson���� 
								var dataObj=eval("("+data1+")");
								var snums ="";
								var type1s="";
								var type2s=""
								var type3s="";
								var type4s="";
								var zhujiao="���У�";
								var beijiao="���У�"
								var zhubeijiao1="";
								var zhujiaode1="";
								var zhujiaoname1="";
								var zhujiaoname3="";
								var zhujiaolingyinname1="";
								var zhujiaolingyincode1="";
								var zhujiaolingyincode3="";
								var zhubeijiao2="";
								var zhujiaode2="";
								var zhujiaoname2="";
								var zhujiaolingyinname2="";
								var zhujiaolingyincode2="";
								var zhubeijiao3="";
								var zhujiaolingyinname3="";
								var zhujiaoname4="";
								var zhujiaolingyincode4="";
								var zhujiaolingyinname4="";
								var zhubeijiao4="";
								
									$.each(dataObj.mftoneboxs,function(idx,item){ 
										//alert(idx+"-----"+item);
										if(idx=="mftoneboxtotalnum") {
											snums=item;
										}
										else {
											return;
										}
	}); 
	
			$.each(dataObj.mftoneboxs,function(idx,item){ 
				//alert(idx+"-----"+item);
										if(idx=="mftonebox") {
									
										}
										else {
											return;
										}
												if(snums=="1") {
											 if(typeof(item.tonebox)=="object") {
                     type1s =item.tonebox[0].toneboxtype;
                     zhujiaoname1=item.tonebox[0].toneboxname;
                     //zhujiaolingyinname1 =item.tonebox[0].toneboxtype;
                     zhujiaolingyincode1 =item.tonebox[0].toneboxcode;
                     var leths1 =item.tonebox[0].tone.length;
                     if(leths1==undefined) {
										 zhujiaolingyinname1+=" "+item.tonebox[0].tone.tonename+"--"+item.tonebox[0].tone.singer+"��";
                     	}
                     	else {
                     for(var i=0;i<leths1;i++) {
                     zhujiaolingyinname1 +=" "+item.tonebox[0].tone[i].tonename+"--"+item.tonebox[0].tone[i].singer+"��"; 
                     }
                    }
											type2s =item.tonebox[1].toneboxtype;
                     zhujiaoname2=item.tonebox[1].toneboxname;
                     //zhujiaolingyinname1 =item.tonebox[0].toneboxtype;
                     zhujiaolingyincode2 =item.tonebox[1].toneboxcode;
                     var leths2 =item.tonebox[1].tone.length;
                      if(leths2==undefined) {
										 zhujiaolingyinname2+=" "+item.tonebox[1].tone.tonename+"--"+item.tonebox[1].tone.singer+"��";
                     	}
                     	else {
                     for(var i=0;i<leths2;i++) {
                     zhujiaolingyinname2 +=" "+item.tonebox[1].tone[i].tonename+"--"+item.tonebox[1].tone[i].singer+"��"; 
                    }
                    }
                     if(type1s=="0") {
                     		zhubeijiao1="���У�"
                     }
                     if(type2s=="1") {
                     		zhubeijiao2=" ���У�"
                     }
 
                     	}
                     else if(typeof(item.tonebox)=="string"){
		                 }else {
		                 	}
											 $("#ssss1").append("<tr><td width='4%'><input type='radio' name='lingyinheradio' value="+item.mftoneboxid+'|'+item.price+"></td><td width='8%'>"+item.mftoneboxid+"</td><td width='17%'>"+item.mftoneboxname+"</td><td width='8%'>"+item.price+"</td><td><strong>"+zhubeijiao1+"</strong>"+zhujiaolingyincode1+" "+zhujiaoname1+" "+zhujiaolingyinname1+"<br/>&nbsp;<strong>"+zhubeijiao2+"</strong>"+zhujiaolingyincode2+" "+zhujiaoname2+" "+zhujiaolingyinname2+"</td></tr>");
										}
										else {
											//alert(typeof(item[0].mftoneboxid));
										for(var is=0;is<snums;is++) {
											//alert(snums);
												//alert(item[is].mftoneboxid);
												//alert(item[is].mftoneboxname);
											type3s =item[is].tonebox[0].toneboxtype;

                     zhujiaoname3=item[is].tonebox[0].toneboxname;
                     //zhujiaolingyinname1 =item.tonebox[0].toneboxtype;
                     zhujiaolingyincode3 =item[is].tonebox[0].toneboxcode;
                     var leths1 =item[is].tonebox[0].tone.length;
                      if(leths1==undefined) {
										 //zhujiaolingyinname3+=" "+item[is].tonebox[0].tone.tonecode+" "+item[is].tonebox[0].tone.tonename+" "+item[is].tonebox[0].tone.singer;
										 zhujiaolingyinname3+=" "+item[is].tonebox[0].tone.tonename+"--"+item[is].tonebox[0].tone.singer+"��";
                     	}
     									else {
                     for(var i=0;i<leths1;i++) {
                     zhujiaolingyinname3 +=" "+item[is].tonebox[0].tone[i].tonename+"--"+item[is].tonebox[0].tone[i].singer+"��"; 
                     }
                     }
                    type4s =item[is].tonebox[1].toneboxtype;
                     zhujiaoname4=item[is].tonebox[1].toneboxname;
                     //zhujiaolingyinname1 =item.tonebox[0].toneboxtype;
                     zhujiaolingyincode4 =item[is].tonebox[1].toneboxcode;
                     var leths2 =item[is].tonebox[1].tone.length;
                      if(leths2==undefined) {
										 zhujiaolingyinname4+=" "+item[is].tonebox[1].tone.tonename+"--"+item[is].tonebox[1].tone.singer+"��";
                     	}
                     	else {
                     for(var i=0;i<leths2;i++) {
                     zhujiaolingyinname4 +=" "+item[is].tonebox[1].tone[i].tonename+"--"+item[is].tonebox[1].tone[i].singer+"��"; 
                    }
                    }
										if(type3s=="0") {
                     		zhubeijiao3="���У�"
                     }
                     if(type4s=="1") {
                     		zhubeijiao4=" ���У�"
                     }
												$("#ssss1").append("<tr><td width='4%'><input type='radio' name='lingyinheradio' value="+item[is].mftoneboxid+'|'+item[is].price+"  ></td><td width='8%'>"+item[is].mftoneboxid+"</td><td width='17%'>"+item[is].mftoneboxname+"</td><td width='8%'>"+item[is].price+"</td><td><strong>"+zhubeijiao3+"</strong>"+zhujiaolingyincode3+" "+zhujiaoname3+" "+zhujiaolingyinname3+"<br/>&nbsp;<strong>"+zhubeijiao4+"</strong>"+zhujiaolingyincode4+" "+zhujiaoname4+" "+zhujiaolingyinname4+"</td></tr>");
												zhujiaolingyinname3="";
												zhujiaolingyinname4="";
										}
										}
				}); 		
			}
			if(data1.length>0 && data1.length<180) {
					var dataObj=eval("("+data1+")"); 
			rdShowMessageDialog(dataObj.returncode,0);
	
			}				
		</script>
	<th>��ѯ���Ϊ��</th>
							<table id="ssss1" name="ssss1" >
							
						</table>

				<%
					}
					%>
					



</body>
</html>
<%
	}
else {
		System.out.println(" ======== sE217Init ����ʧ�� ========" + retCode + " | " + retMsg);
		%>
			<script language="JavaScript">
					    rdShowMessageDialog("<%=retCode%>"+"<%=retMsg%>",0);	
					</script>
					<%
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//Dtd Xhtml 1.0 transitional//EN" "http://www.w3.org/tr/xhtml1/Dtd/xhtml1-transitional.dtd">
<%
  /*
   * ����: ȫ��ͨVIP�򳵷���
   * �汾: 2.0
   * ����: 2011/11/16
   * ����: weigp
   * ��Ȩ: si-tech
   * update:
   */
%>
<%
//begin huangrong add 2011-3-25
	String phoneNo = WtcUtil.repNull(request.getParameter("phoneNo"));
	String IDType = WtcUtil.repNull(request.getParameter("IDType"));
	String custPWD = WtcUtil.repNull(request.getParameter("custPWD"));
	String cardType = WtcUtil.repNull(request.getParameter("cardType"));
	String cardID = WtcUtil.repNull(request.getParameter("cardID"));
	System.out.println("---------------------------"+cardID);
//end huangrong add

	String opCode = request.getParameter("opCode");
	String opName = "ȫ��ͨVIP�򳵷���";
	String orgCode =(String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String tri_detailMsg = "";
	java.util.Date date = new java.util.Date();
	java.text.DateFormat format = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
	String todayTime = format.format(date);
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
%>
<%@ page contentType="text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<%!
		    public static String createArray(String aimArrayName, int xDimension) {
		        String stringArray = "var " + aimArrayName + " = new Array(";
		        int flag = 1;
		        for (int i = 0; i < xDimension; i++) {
		            if (flag == 1) {
		                stringArray = stringArray + "new Array()";
		                flag = 0;
		                continue;
		            }
		            if (flag == 0) {
		                stringArray = stringArray + ",new Array()";
		            }
		        }

		        stringArray = stringArray + ");";
		        return stringArray;
		    }
		%>
		<%
			//��ȡһ��BOSS������ʡ��
			String proSql = "select substr(node_code,0,3),node_name from oneboss.sobexchgnode where domain_id = 'BOSS' order by node_code";
		%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode" retmsg="retMsg" outnum="2">
		<wtc:sql><%=proSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result" scope="end" />
		<%
		if(result.length > 0){
			for(int i=0;i<result.length;i++){
				System.out.println("node_code="+result[i][0]+"--------->node_name="+result[i][1]);
			}
		}else{
		%>
			rdShowMessageDialog("��ȡʡ����Ϣʧ�ܣ�");
		<%
		}
		%>
		<%
			//��ȡ�����б�
			String servSql = "select a.avc_code,a.item_code,a.item_name,a.item_price,a.item_score,b.avc_name from SVIPSvcItemCode a,SVIPSvcCode b where a.avc_code = b.avc_code";
		%>
		<wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="6">
		<wtc:sql><%=servSql%></wtc:sql>
		</wtc:pubselect>
		<wtc:array id="result1" scope="end" />
		<%
			if(result1.length <= 0){
		%>
				rdShowMessageDialog("��ȡ������Ϣʧ�ܣ�");
		<%
			}else{
				tri_detailMsg = createArray("servArr", result1.length);
			}
		%>

		<title>ȫ��ͨVIP�򳵷���</title>
		<script type="text/javascript">
		<%=tri_detailMsg%>
			<%
			    for (int p = 0; p < result1.length; p++) {
			        for (int q = 0; q < result1[p].length; q++) {
			%>
						servArr[<%=p%>][<%=q%>]="<%=result1[p][q]%>";
			<%
			        }
			    }
			%>

			$(document).ready(function () {
				//begin huangrong add
				if("<%=IDType%>"!="")
				{
					if("<%=IDType%>"=="03")
					{
						document.f1.cardType.value="00";
                    }
					else
					{
						document.f1.cardType.value="01";
					}

				}
				//end huangrong add
				//չʾ�����б�
				for(var i=0;i<servArr.length;i++){
					if(servArr[i][0] != "03"){
						tr1=dyntb.insertRow();
						tr1.id=i;
						tr1.insertCell().innerHTML = '<div align="center"><input type=checkBox size=4  value="'+i+'" checked ></input></div>';
						tr1.insertCell().innerHTML = '<div align="center"><input id="oneCode'+i+'" type=text size=8  value="'+ servArr[i][0]+'"  readonly></input><input id="oneName'+i+'" type="hidden" value="'+servArr[i][5]+'"/></div>';
						tr1.insertCell().innerHTML = '<div align="center"><input id="twoCode'+i+'" type=text size=8  value="'+ servArr[i][1]+'"  readonly></input></div>';
						tr1.insertCell().innerHTML = '<div align="center"><input id="twoNameCode'+i+'" type=text   value="'+ servArr[i][2]+'"  readonly></input></div>';
						tr1.insertCell().innerHTML = '<div align="center"><input type=text   value="'+ servArr[i][2]+'"  maxlength="200" readonly></input></div>';
						tr1.insertCell().innerHTML = '<div align="center"><input id="price'+i+'" type=text align="right" size=9  style="text-align:right" value="'+ servArr[i][3]+'"  v_type=cfloat v_maxlength="12.2"  v_name="���" maxlength="9" readonly></input></div>';
						tr1.insertCell().innerHTML = '<div align="center"><input id="score'+i+'" type=text  align="right" size=12 style="text-align:right"  value="'+ servArr[i][4]+'"  v_type=0_9 v_minlength="1" v_name="�ۺ�Ӧ�ۻ���" maxlength="9" readonly></input></div>';
					}
				}

				//����Ԥ��ѡ�񣬿�������չʾ
				$("input[type='radio']").bind("click",function(){
					if($(this).val()=="0"){
						$("#showTqyb").show();
					}else{
						$("#showTqyb").hide();
					}
				});
				//ʡ������
				$("#provinceId").change(function(){
					var packet = new AJAXPacket("ajaxGetCity.jsp","���Ժ�...");
					packet.data.add("provinceVal",$(this).val());
					core.ajax.sendPacket(packet,function(packet){
							var str = packet.data.findValueByName("str");
							var jsonObj = eval("("+str+")");
							$("#cityId").empty();
							for(var i =0;i<jsonObj.citys.length;i++){
								$("#cityId").append("<option value="+jsonObj.citys[i].cityCode+">"+jsonObj.citys[i].cityName+"</option>");
							}
						});
					packet = null;
				});

				//���ݷ��񼶱�չʾ����
				$("#servLevel").bind("change",function(){
					for(var a = dyntb.rows.length-2 ;a>=0; a--)//ɾ����tr1��ʼ��Ϊ������
					{
				            dyntb.deleteRow(a+1);
					}
					if($(this).val() == "1"){
						for(var i=0;i<servArr.length;i++){
							if(servArr[i][0] != "03"){
								tr1=dyntb.insertRow();
								tr1.id=i;
								tr1.insertCell().innerHTML = '<div align="center"><input type=checkBox size=4  value="'+i+'" checked ></input></div>';
						        tr1.insertCell().innerHTML = '<div align="center"><input id="oneCode'+i+'" type=text size=8  value="'+ servArr[i][0]+'"  readonly></input><input id="oneName'+i+'" type="hidden" value="'+servArr[i][5]+'"/></div>';
						        tr1.insertCell().innerHTML = '<div align="center"><input id="twoCode'+i+'" type=text size=8  value="'+ servArr[i][1]+'"  readonly></input></div>';
						        tr1.insertCell().innerHTML = '<div align="center"><input id="twoNameCode'+i+'" type=text   value="'+ servArr[i][2]+'"  readonly></input></div>';
						        tr1.insertCell().innerHTML = '<div align="center"><input type=text   value="'+ servArr[i][2]+'"  maxlength="200" readonly></input></div>';
						        tr1.insertCell().innerHTML = '<div align="center"><input id="price'+i+'" type=text align="right" size=9  style="text-align:right" value="'+ servArr[i][3]+'"  v_type=cfloat v_maxlength="12.2"  v_name="���" maxlength="9" readonly></input></div>';
						        tr1.insertCell().innerHTML = '<div align="center"><input id="score'+i+'" type=text  align="right" size=12 style="text-align:right"  value="'+ servArr[i][4]+'"  v_type=0_9 v_minlength="1" v_name="�ۺ�Ӧ�ۻ���" maxlength="9" readonly></input></div>';
							}

						}
					}else if($(this).val() == "2"){
						for(var i=0;i<servArr.length;i++){
							tr1=dyntb.insertRow();
							tr1.id=i;
							tr1.insertCell().innerHTML = '<div align="center"><input type=checkBox size=4  value="'+i+'" checked ></input></div>';
						        tr1.insertCell().innerHTML = '<div align="center"><input id="oneCode'+i+'" type=text size=8  value="'+ servArr[i][0]+'"  readonly></input><input id="oneName'+i+'" type="hidden" value="'+servArr[i][5]+'"/></div>';
						        tr1.insertCell().innerHTML = '<div align="center"><input id="twoCode'+i+'" type=text size=8  value="'+ servArr[i][1]+'"  readonly></input></div>';
						        tr1.insertCell().innerHTML = '<div align="center"><input id="twoNameCode'+i+'" type=text   value="'+ servArr[i][2]+'"  readonly></input></div>';
						        tr1.insertCell().innerHTML = '<div align="center"><input type=text   value="'+ servArr[i][2]+'"  maxlength="200" readonly></input></div>';
						        tr1.insertCell().innerHTML = '<div align="center"><input id="price'+i+'" type=text align="right" size=9  style="text-align:right" value="'+ servArr[i][3]+'"  v_type=cfloat v_maxlength="12.2"  v_name="���" maxlength="9" readonly></input></div>';
						        tr1.insertCell().innerHTML = '<div align="center"><input id="score'+i+'" type=text  align="right" size=12 style="text-align:right"  value="'+ servArr[i][4]+'"  v_type=0_9 v_minlength="1" v_name="�ۺ�Ӧ�ۻ���" maxlength="9" readonly></input></div>';
						}
					}
				});

				//��ѯʹ�û�������
				$("#countBtn").bind("click",function(){
					var oneCodeArr = "";
					var oneNameArr = "";
					var twoCodeArr = "";
					var twoNameArr = "";
					var priceArr = "";
					var scoreArr = "";
					var totalPrice = 0;
					var totalScore = 0;
					$("input[type='checkbox']").each(function(){//�����������
 	  					if($(this).attr("checked")) {
 	  						// alert($(this));
							totalPrice += parseInt($("#price"+$(this).val()).val());
							totalScore += parseInt($("#score"+$(this).val()).val());
							oneCodeArr += $("#oneCode"+$(this).val()).val()+"|";
							oneNameArr += $("#oneName"+$(this).val()).val()+"|";
							twoCodeArr += $("#twoCode"+$(this).val()).val()+"~";
							twoNameArr += $("#twoNameCode"+$(this).val()).val()+"~";
							priceArr += $("#price"+$(this).val()).val()+"|";
							scoreArr += $("#score"+$(this).val()).val()+"|";
 	  					}
 	  				});


					if($("#servLevel").val() == "1"){//�ܻ�����Ҫ������ѡ����*�����Ļ���
						totalScore += 2000 * (parseInt($("#personNum").val()) + 1);
					}else{
						totalScore += 3000 * (parseInt($("#personNum").val()) + 1);
					}
					if($("#servLevel").val() == "1"){//�����Ҫ������ѡ����*�����Ļ���
						totalPrice += 30 * (parseInt($("#personNum").val()) + 1);
					}else{
						totalPrice += 50 * (parseInt($("#personNum").val()) + 1);
					}

					if(parseInt($("#personNum").val()) > 0){//������Ա�������޶�
						oneCodeArr += "06|";
						oneNameArr += $("#personNum").val()+"|";
						twoCodeArr += "01~";
						twoNameArr += "��Ա����~";
						priceArr   += "0.00|";
						scoreArr   += "0|";
					}
					$("#totalScore").val(totalScore);
					$("#totalPrice").val(totalPrice);
					$("#oneCodeArr").val(oneCodeArr);
					$("#oneNameArr").val(oneNameArr);
					$("#twoCodeArr").val(twoCodeArr);
					$("#twoNameArr").val(twoNameArr);
					$("#priceArr").val(priceArr);
					$("#scoreArr").val(scoreArr);

				});

				//��Ȩ
				$("#vallidateBtn").bind("click",function(){
			
					if($("#custPhone").val()==""){
						rdShowMessageDialog("������ͻ���ʶ��");
						return;
					}
					if($("#cardNo").val()==""){
						rdShowMessageDialog("������֤�����룡");
						return;
					}
					var packet = new AJAXPacket("ajaxChkCust.jsp?sheng_flag=w","���Ժ�...");
					packet.data.add("custPhone",$("#custPhone").val());
					packet.data.add("cardType",$("#cardType").val());
					packet.data.add("custPwd",$("#custPwd").val());
					packet.data.add("cardNo",$("#cardNo").val());
					packet.data.add("servLevel",$("#servLevel").val());
					packet.data.add("personNum",$("#personNum").val());
					core.ajax.sendPacket(packet,function(packet){
							var	errCode = packet.data.findValueByName("errCode");
							var	errMsg = packet.data.findValueByName("errMsg");
							var	flag = packet.data.findValueByName("flag");
							var oRejectReason = packet.data.findValueByName("oRejectReason");
							if(flag == "false"){//���ṩ����ʱ
								rdShowMessageDialog("������룺"+errCode+"��������Ϣ��"+errMsg);
								$("#custPhone").val("");
								$("#cardNo").val("");
								$("#custPwd").val("");
								$("#personNum").val("0");
								return ;
							}
							$("#custName").val(packet.data.findValueByName("oCustName"));//�ͻ�����
							$("#iccNo").val($("#cardNo").val());
							$("#oRejectReason").val(oRejectReason);//�ܾ�����
							var oUserStatus = packet.data.findValueByName("oUserStatus");//�ͻ�״̬
							$("#oUserStatus").val(oUserStatus);
							var oUserRank = packet.data.findValueByName("oUserRank");//�ͻ�����
							$("#oUserRank").val(oUserRank);
							$("#oSvcPhNum").val(packet.data.findValueByName("oSvcPhNum"));//��ͻ�������ϵ�绰
							$("#oUserScore").val(packet.data.findValueByName("oUserScore"));//�ͻ����û������
							if(oRejectReason == "00"){
								$("#confirm").attr("disabled",false);
								$("#countBtn").attr("disabled",false);
							}else{
								$("#confirm").attr("disabled",true);
								$("#countBtn").attr("disabled",true);
							}
						});
					packet = null;
				});
				//ȷ���ύ
				$("#confirm").bind("click",function(){
					if(check(f1)){
						if($("#totalPrice").val()==""){
							rdShowMessageDialog("���ѯ�ܽ��");
							return;
						}
						if($("#totalScore").val()==""){
							rdShowMessageDialog("���ѯ�ܻ���");
							return ;
						}
						//ѡ������Ԥ��ʱ����֤�ִ�ʱ��
						if($("input[type='radio'][checked]").val() == "0"){
							if($("#destDate").val() == ""){
								rdShowMessageDialog("�ִ�ʱ������");
								return ;
							}
						}

						$("#f1").submit();
					}
				});
			});

		</script>
	</head>
	<body>
		<form method="post" id="f1" name="f1" action="fb878Cfm.jsp?sheng_flag=w" onKeyUp="chgFocus(f1)">
			<%@ include file="/npage/include/header.jsp" %>
			<div class="title">
				<div id="title_zi">ȫ��ͨVIP�򳵷���</div>
			</div>
			<table cellspacing="0">
				<tr>
					<td width="10%" class="blue">��ͨ��ʽ</td>
					<td width="20%" class="blue" colspan="3">
						<select disabled>
							<option checked>��ʽ</option>
							<option>����</option>
						</select>
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">��������</td>
					<td width="20%" class="blue">
						<input type="text" value="ȫ��ͨVIP�򳵷���" readonly/>
					</td>
					<td width="20%" class="blue" colspan="2">
						&nbsp;
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">�ͻ���ʶ����</td>
					<td width="20%" class="blue">
						<select disabled>
							<option>�ֻ�����</option>
						</select>
					</td>
					<td width="10%" class="blue">�ͻ���ʶ</td>
					<td width="20%" class="blue">
						<input type="text" v_must=1 v_name="�ͻ���ʶ" id="custPhone" name="custPhone" value="<%=phoneNo%>" Class="InputGrey"  readonly maxlength="14" onblur="checkElement(this)"/>
						<font class="orange">*</font>
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">�ͻ�����</td>
					<td width="20%" class="blue" colspan="3">
						<input type="password" v_must=1 id="custPwd" name="custPwd" value="<%=custPWD%>" v_name="�ͻ�����" maxlength="6" />
						<!--<font class="orange">*</font>-->
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">֤������</td>
					<td width="20%" class="blue">
						<select name="cardType" id="cardType">
							<option value="00">00--&gt;���֤</option>
			                <option value="01">01--&gt;VIP��</option>
						</select>
					</td>
					<td width="10%" class="blue">֤������</td>
					<td width="20%" class="blue">
						<input type="text" v_must=1 id="cardNo" name="cardNo" v_name="֤������" value="<%=cardID%>" onblur="checkElement(this)"/>
						<font class="orange">*</font>
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">���񼶱�</td>
					<td width="20%" class="blue">
						<select id="servLevel" name="servLevel">
							<option value="1">һ������</option>
							<option value="2">��������</option>
						</select>
					</td>
					<td width="10%" class="blue">��Ա����</td>
					<td width="20%" class="blue">
						<input type="text" value="0" id="personNum" name="personNum"/>(��������)
						<input type="button" class="b_text"  value="��֤" id="vallidateBtn"/>
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">�ͻ�����</td>
					<td width="20%" class="blue">
						<input type="text" readonly id="custName" name="custName"/>
					</td>
					<td width="10%" class="blue">֤�����ͼ�����</td>
					<td width="20%" class="blue">
						<input type="text" readonly id="iccNo" name="iccNo"/>
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">�û�״̬</td>
					<td width="20%" class="blue">
						<select id="oUserStatus" disabled name="oUserStatus">
							<option value="00">����</option>
							<option value="01">����ͣ��</option>
							<option value="02">ͣ��</option>
							<option value="03">Ԥ����</option>
							<option value="04">����</option>
							<option value="05">����</option>
							<option value="06">�ĺ�</option>
							<option value="90">�������û�</option>
							<option value="99">�˺��벻����</option>
						</select>
					</td>
					<td width="10%" class="blue">�ͻ�����</td>
					<td width="20%" class="blue">
						<select id="oUserRank" disabled name="oUserRank">
							<option value="000">����</option>
							<option value="100">��ͨ�ͻ�</option>
							<option value="200">��Ҫ�ͻ�</option>
							<option value="201">�������ؿͻ�</option>
							<option value="202">����������ȫ���ؿͻ�</option>
							<option value="203">��ͨ�������ͻ�</option>
							<option value="204">Ӣ�ۡ�ģ����������ͻ�</option>
							<option value="300">��ͨ��ͻ�</option>
							<option value="301">��ʯ����ͻ�</option>
							<option value="302">�𿨴�ͻ�</option>
							<option value="303">������ͻ�</option>
							<option value="304">�������ͻ�</option>
						</select>
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">�ͻ�����</td>
					<td width="20%" class="blue" colspan="3">
						<input type="text" readonly id="oUserScore" name="oUserScore"/>
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">��ͻ�����绰</td>
					<td width="20%" class="blue">
						<input type="text" readonly id="oSvcPhNum" name="oSvcPhNum"/>
					</td>
					<td width="10%" class="blue">����ܾ�����</td>
					<td width="20%" class="blue">
						<select id="oRejectReason" name="oRejectReason" style="width:200px" disabled>
							<option value="00">��Ȩ�ɹ�</option>
							<option value="01">�ͻ����ֲ���</option>
							<option value="02">�ͻ����𲻹�</option>
							<option value="03">�ͻ��������</option>
							<option value="04">�ͻ����֤�����vip���Ŵ���</option>
							<option value="05">�޴��û�</option>
							<option value="06">�ͻ�״̬������,�޷��ṩ����</option>
							<option value="07">���ſͻ�,�޸��������Ϣ,����VIP����ȷ��</option>
							<option value="99">��������,��ʡ��˾���н���</option>
						</select>
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">����ʱ��</td>
					<td width="20%" class="blue" >
						<input type="text" value="<%=todayTime%>" name="enterTime" maxlength="14" v_type="dateTime" v_must=1  v_minlength=14  v_name="����ʱ��" />
						<font class="orange">*</font>
						(��ʽ:YYYYMMDDHHMMSS)
					</td>
					<td width="10%" class="blue">�뿪ʱ��</td>
					<td width="20%" class="blue">
						<input type="text" value="<%=todayTime%>" name="leaveTime" maxlength="14" v_type="dateTime" v_must=1  v_minlength=14  v_name="�뿪ʱ��"/>
						<font class="orange">*</font>
						(��ʽ:YYYYMMDDHHMMSS)
					</td>
				</tr>
				<tr>
					<td width="10%" class="blue">�Ƿ�Ԥ������Ԥ������</td>
					<td width="10%" class="blue" colspan="3">
						ѡ��:<input type="radio" name="tqyb" id="tqyb" value="0">&nbsp;&nbsp;
						��ѡ��<input type="radio" name="tqyb" id="tqyb" value="1" checked>
					</td>
				</tr>
				<tr id="showTqyb" style="display:none">
					<td class="blue">���͵�</td>
					<td colspan="3" class="blue">
						ʡ��:
						<select id="provinceId" name="proCode">
						<%
						for(int i=0;i<result.length;i++){
						%>
							<option value="<%=result[i][0]%>"><%=result[i][1]%></option>
						<%
						}
						%>
						</select>
						<font class="orange">*</font>
						����:
						<select id="cityId" name="cityCode">
							<option value="010">����</option>
						</select>
						<font class="orange">*</font>
						<br>
						&nbsp;ʱ��:
						<input type="text" id="destDate" name="destDate" v_must=0 v_type = "date" onblur="checkElement(this)"/>
						<font class="orange">*(��ʽ:YYYYMMDD)</font>
						�Ƿ�Ԥ���ڶ��죺
						<select id="morrowFlag" name="morrowFlag">
							<option value="0">��</option>
							<option value="1">��</option>
						</select>
					</td>
				</tr>
			</table>
			<div id="serviceList">
				<div class="title">
					<div id="title_zi">�����б�</div>
				</div>
				<table id="dyntb" name="dyntb">
					<tr>
						<td class="blue">ѡ��</td>
						<td class="blue">һ������</td>
						<td class="blue">��������</td>
						<td class="blue">������������</td>
						<td class="blue">��������</td>
						<td class="blue">���</td>
						<td class="blue">�ۺ�Ӧ�ۻ���</td>
					</tr>
				</table>
				<table>
					<tr>
						<td colspan="7">
							<input type="button" class="b_text" value="�����ܶ�" id="countBtn" disabled />
						</td>
					</tr>
					<tr>
						<td>�ܼƽ��</td>
						<td colspan="2">
							<input type="text" readonly id="totalPrice" v_must=1 name="totalPrice"/>
							<font class="orange">*</font>
						</td>
						<td colspan="2">�ܿۻ���</td>
						<td colspan="2">
							<input type="text" readonly id="totalScore" v_must=1 name="totalScore"/>
							<font class="orange">*</font>
						</td>
					</tr>
				</table>
			</div>
			<table cellspacing="0">
				<tr>
					<td colspan="4" id="footer">
			           <div align="center">
			              <input class="b_foot" type="button" id="confirm" name="confirm" value="ȷ��" index="2" disabled >
			              <input class="b_foot" type="button" name=back value="���" onClick="f1.reset()">
					          <input class="b_foot" type="button" name=qryP value="�ر�" onClick="parent.removeTab('<%=opCode%>');">
					          <input class="b_foot" type="button" name=comeback value="����" onClick="history.go(-1);">
			            </div>
			        </td>
				</tr>
			</table>
			<input type="hidden" name="oneCodeArr" id="oneCodeArr" />
			<input type="hidden" name="oneNameArr" id="oneNameArr" />
			<input type="hidden" name="twoCodeArr" id="twoCodeArr" />
			<input type="hidden" name="twoNameArr" id="twoNameArr" />
			<input type="hidden" name="priceArr" id="priceArr" />
			<input type="hidden" name="scoreArr" id="scoreArr" />
			<%@ include file="/npage/include/footer.jsp" %>
		</form>
	</body>
</html>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v3.0
������: si-tech
********************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.Encrypt"%>
<%@ include file="../../npage/bill/getMaxAccept.jsp" %>
<%
		response.setHeader("Pragma","No-Cache"); 
		response.setHeader("Cache-Control","No-Cache");
		response.setDateHeader("Expires", 0); 
    	//sale_type = 43
    	String printName = "����Ҹ���ͥ��Ա";
    	
 		String opCode = request.getParameter("opCode");
 		String opName = request.getParameter("opName");
 		String familyCode = request.getParameter("familyCode");
 		String printOpName = "";
 		/*gaopeng ���ֿ����ͥ���ںϼ�ͥ�������ӡͷ��չʾ��2014/01/15 16:46:18*/
 		if(familyCode.equals("KDJT")){
 			printOpName = "�����ͥ";
 		}else if(familyCode.equals("RHJT")){
 			printOpName = "�ںϼ�ͥ";
 		}
 		String familyName = request.getParameter("familyName");
 		String belongGroupId = request.getParameter("belongGroupId");
 		String parentPhone = request.getParameter("parentPhone");
 		String regionCode= (String)session.getAttribute("regCode");
 		String work_no = (String)session.getAttribute("workNo");
 		String password = (String)session.getAttribute("password");
 		String cccTime=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault()).format(new java.util.Date());
		String printAccept="";
		String[][] familyMemberList = new String[][]{};
		String prodCode = "";
		String create_accept = "";
		System.out.println("---liujian begin----");
%>
		<script>
			//��ʼ���û��б�����
			var initUserArr = new Array();
			
			/*
			 * ��÷��񷵻ص����ݣ���װ��һЩ�е�js����
			 * �û�����
			 * @param {Object} famCode ��ͥ����
			 * @param {Object} famName ��ͥ����
			 * @param {Object} phone �ֻ���
			 * @param {Object} role �û���ɫ 
			 * @param {Object} beginTime ��Чʱ��
			 * @param {Object} endTime ʧЧʱ��
			 * @param {Object} editSts �Ƿ�ɱ༭
			 */
			function InitUser(famCode,famName,phone,role,beginTime,endTime,editSts) {
				this.famCode = famCode;
				this.famName = famName;
				this.phone = phone;
				this.role = role;
				this.beginTime = beginTime;
				this.endTime = endTime;
				this.editSts = editSts;
			}	
		</script>
		
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="region" 
		 routerValue="<%=regionCode%>"  id="seq"/>
	<wtc:sequence name="TlsPubSelCrm" key="sMaxSysAccept" routerKey="region" 
		 routerValue="<%=regionCode%>"  id="seq2"/>
<%
	printAccept = seq;
	create_accept = seq2;
	System.out.println("----liujian-----printAccept=" + printAccept);
%>
	<wtc:service name="sFamSelCheck" routerKey="region" routerValue="<%=regionCode%>" 
		retmsg="msg1" retcode="code1" outnum="12">
		<wtc:param value="<%=printAccept%>"/>
		<wtc:param value="01"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=work_no%>"/>
		<wtc:param value="<%=password%>"/>
		<wtc:param value="<%=parentPhone%>"/>
		<wtc:param value=""/>
		<wtc:param value="3"/>
		<wtc:param value="<%=familyCode%>"/>
	</wtc:service>
	<wtc:array id="result1" scope="end" />
<%
	System.out.println("========== liujian  ====" + code1 + " | " + result1.length);
	if("000000".equals(code1)){
		familyMemberList = result1;
		System.out.println("------------------liujian------------------result1.length=" + result1.length);
		for(int i = 0; i < familyMemberList.length; i++){
			if(familyMemberList[i][1].equals("M")){
					prodCode = familyMemberList[i][8];
				}
%>
		<script>
			var famCode = '<%=familyCode%>';//��ͥ����
			var famName = '<%=familyName%>';//��ͥ����
			var phone = '<%=familyMemberList[i][3]%>';//�ֻ�����
			var role = '<%=familyMemberList[i][2]%>';//��ɫ����
			var beginTime = '<%=familyMemberList[i][4]%>';//��Чʱ��
			var endTime = '<%=familyMemberList[i][5]%>';//ʧЧʱ��
			//�ɱ����ʶ��0�ɣ�1����
			var editSts = '<%=familyMemberList[i][11]%>';//�༭״̬
			initUserArr.push(new InitUser(famCode,famName,phone,role,beginTime,endTime,editSts));
		</script>
<%			
		}
	}else{
%>
		<script language="JavaScript">
			rdShowMessageDialog("û�в�ѯ����ͥ��ɫ��Ϣ" + "<%=code1%>" + "<%=msg1%>");
			window.location="fe280.jsp?activePhone=<%=parentPhone%>";
		</script>
<%
	}
%>	
<html>
<head>
	<title>��ͥ��Ʒ���</title>
	<script language="javascript" type="text/javascript" src="/njs/plugins/My97DatePicker/WdatePicker.js"></script>
	<script language="javascript" type="text/javascript" src="/npage/public/json2.js"></script>
	<script language="javascript">
		//������û��б�����
		var variedUserArr = new Array();
		var varySubmitBtnSts = -1;//0���������붼û��֤ͨ����1��һ����֤����ͨ����2��������֤����ͨ��
		var sourceSts = -1;//-1:��Ҫ��֤���룬0��û����֤���룻1����֤����
		var destSts = -1;//-1:��Ҫ��֤���룬0��û����֤���룻1����֤����
		var sourceOrDest = -1;//��֤�ĸ��ֻ������룬0��source��1��dest
		/*
		 * �������û�����֮���Դ����µĶ��󣬱���ʵ��ɾ������Ӳ��������ұ��ڻ�ñ�����
		 * @param {Object} phone Դ�ֻ���
		 * @param {Object} afterPhone Ŀ���ֻ���
		 * @param {Object} exsitAfterPhone Ŀ���û��Ƿ��Ǽ�ͥ��Ա �������Ϊtrue������Ϊfalse
		 */
		function VariedUser(phone,afterPhone,exsitAfterPhone) {
			this.phone = phone;
			this.afterPhone = afterPhone;
		//	this.role = role;
			this.exsitAfterPhone = exsitAfterPhone;
		}
		
		/*
		 * �жϳ�ʼ���û��������Ƿ����Ŀ���ֻ�����
		 * @param {Object} phone �ֻ���
		 */
		function judgePhoneExsit(phone) {
			return (initUserArr.indexOfByValue(phone,"phone") > -1) ;
		}
		
		/*
		 * Ŀ���ֻ������Ƿ����ѱ�������ֻ�����
		 * 1. �ѱ�����ļ�ͥ����
		 * 2. �ѱ�������¼Ӻ���
		 * 3. ���ܱ���ļ�ͥ����
		 * �жϱ���û�������(afterPhone)�Ƿ����Ŀ���ֻ�����
		 * @param {Object} phone �ֻ���
		 */
		function judgeDestPhoneUsed(phone) {
			var f1 = variedUserArr.indexOfByValue(phone,'afterPhone') > -1 ;
			var f2 = variedUserArr.indexOfByValue(phone,'phone') > -1;
			var f3 = initUserArr.getElByValue(phone,'phone').editSts == '1';
			return f1 || f2 || f3;
			/*
			return variedUserArr.indexOfByValue(phone,"afterPhone") > -1 
				|| variedUserArr.indexOfByValue(phone,"phone") > -1
				|| initUserArr.getElByValue(phone).editSts == '1';
			*/
		}
		
		function judgeSourcePhoneVarid(phone) {
			return variedUserArr.indexOfByValue(phone,"phone") > -1;
		}
		
		/*
		 * Array�·���indexOfByValue
		 * �ж϶����name���Ե�valֵ���Ƿ����Array��
		 * @param {Object} val
		 * @param {Object} name
		 */
		Array.prototype.indexOfByValue = function(val,name) {
	        for (var i = 0; i < this.length; i++) {
	            if (this[i][name] == val) return i;
	        }
	        return -1;
	    };
		
		/*
		 * Array�·���removeElByValue
		 * ɾ�������еĶ��󣬸ö����name������valֵ
		 * @param {Object} val
		 * @param {Object} name
		 */
	    Array.prototype.removeElByValue = function(val,name) {
	        var index = this.indexOfByValue(val,name);
	        if (index > -1) {
	            this.splice(index, 1);
	        }
	    }; 
	    
	    /*
		 * Array�·���removeElsByValue
		 * ɾ�������еĶ�����󣬸ö����name������valֵ
		 * @param {Object} val
		 * @param {Object} name
		 */
		Array.prototype.removeElsByValue = function(val,name) {
	        for (var i = 0; i < this.length; i++) {
	            if (this[i][name] == val)  {
	            	this.splice(i, 1);
	            	i--;
	            }
	        }
	    }; 
		/*
		 * Array�·���getElByValue
		 * ��������еĶ��󣬸ö����name������valֵ
		 * @param {Object} val
		 * @param {Object} name
		 */
	    Array.prototype.getElByValue = function(val,name) {
	        for (var i = 0; i < this.length; i++) {
	            if (this[i][name] == val)  {
	            	return this[i];
	            }
	        }
	        return -1;
	    }; 
	   
		//�����ȷ�������ݴ浽����
		var tempFamUserArray = new Array();
		//���û�����⣬����resultArr
		var resulFamUsertArr = new Array();
		/*
		 * business_id    ����ID
		 * exec_order      �����˶���ʶ�� 1������ 3�˶�
		 * newofferid     �ʷѴ���
		 * busitype       ��Ʒ���
		 */
		 var offeriddd1="";
		 var offeriddd2="";
		 var cheoffersid="";
		function Busi(business_id,exec_order,newofferid,busitype) {
			this.business_id = business_id;
			this.exec_order = exec_order;
			this.newofferid = newofferid;
			this.busitype = busitype;
			//alert(business_id+"--"+exec_order+"--"+newofferid+"--"+busitype);
			if(busitype=="AO") {
				if(exec_order=="1") {
			if(cheoffersid=="") {
				offeriddd1 =newofferid;

			}
			if(cheoffersid !="" ) {
				offeriddd2 =newofferid;					
			}
			
			cheoffersid=newofferid;
			
		}
	}
		}
		
		/*
		 * length                �������
		 * businesses            �����������
		 * phone_no_subordinate  �ֻ�����
		 * family_role           ��ɫcode  M�ҳ�  O������Ա
		 * family_role_name      ��ɫ����
		 * member_role_id        ��Ա��ɫcode ����70001
		 * pay_type              ���ѷ�ʽ  G �����˻�
		 */
		function FamUser(length,businesses,phone_no_subordinate,family_role,family_role_name,
					member_role_id,pay_type) {
			this.length = length;
			this.businesses = businesses;
			this.phone_no_subordinate = phone_no_subordinate;
			this.family_role = family_role;
			this.family_role_name = family_role_name;
			this.member_role_id = member_role_id;
			this.pay_type = pay_type;
		}
		
		/*
		 * ��󷵸�����Ķ����������ת��json��
		*/
		function FamUsers(length,famRoles,create_accept,chnsource,opCode,loginNo,password,phone_no_master,
				op_note,prod_code,family_code,pay_money,vary_source_phones,vary_dest_phones) {
			this.length = length;
			this.famRoles = famRoles;
			this.create_accept = create_accept;
			this.chnsource = chnsource;	
			this.opCode = opCode;
			this.loginNo = loginNo;				  	
			this.password = password;
			this.phone_no_master = phone_no_master;	
			this.op_note = op_note;
			this.prod_code = prod_code;	
			this.family_code = family_code;	
			this.pay_money = pay_money;
			this.vary_source_phones = vary_source_phones;				  	
			this.vary_dest_phones = vary_dest_phones;
		}
		
		$(function() {
			$('#opCode').val('<%=opCode%>');
			$('#opName').val('<%=opName%>');
			$('#parentPhone').val('<%=parentPhone%>');
			setvarySubmitBtnDisabled();
			var getdataPacket = new AJAXPacket("pubGetCustInfo.jsp","���ڻ�����ݣ����Ժ�......");
			getdataPacket.data.add("phoneNo","<%=parentPhone%>");
			core.ajax.sendPacket(getdataPacket,doPubGetInfoBack,true);
			getdataPacket = null;
			
			var prodCode = "<%=prodCode%>";
			$("#familyProdInfo option[value='" + prodCode + "']").attr("selected","selected");
			$("#familyProdInfo").attr("disabled","true");
			
			initRoleTbodyRefrech();
			
			//�����ťȷ��
			$('#varySubmitBtn').click(function() {
				//�����޸�Դ�ֻ����������
				var sourcePhone = $('#sourcePhone').val();
				var destPhone = $('#destPhone').val();
				if(checkPhone(sourcePhone,destPhone)) {
					//1.�ж�Ŀ���ֻ������Ƿ��ǳ�ʼ����Ա�к��е��ֻ�����
					var _flag = judgePhoneExsit(destPhone);
					if(_flag) {
						 //2.1 �������������Դ�ֻ��ź�Ŀ���ֻ��Ų����ٴα��;
						 //	  ���һ���������exsitAfterPhone=true;
						 //    ���ѱ����ɫ�������һ����¼
						$('#initRoleTbody').find('input[id="' + sourcePhone + '"]').attr('disabled',true)
						$('#initRoleTbody').find('input[id="' + destPhone + '"]').attr('disabled',true);
						variedUserArr.push(new VariedUser(sourcePhone,destPhone,_flag));
					//	variedUserArr.push(new VariedUser(destPhone,sourcePhone,_flag));
						$('#variedRoleListTb').append('<tr><td>' + sourcePhone + '</td><td>' + destPhone +'</td><td><input type="button" value="ɾ��" class="b_text" onclick="delVariedRec(this)" /></td></tr>');
					}else {
						//2.2 ���������������Դ�ֻ��Ų����ٴα��;
						//    ���һ���������exsitAfterPhone=false;
						//    ���ѱ����ɫ�������һ����¼
						$('#initRoleTbody').find('input[id="' + sourcePhone + '"]').attr('disabled',true)
						variedUserArr.push(new VariedUser(sourcePhone,destPhone,_flag));
						$('#variedRoleListTb').append('<tr><td>' + sourcePhone + '</td><td>' + destPhone +'</td><td><input type="button" value="ɾ��" class="b_text" onclick="delVariedRec(this)" /></td></tr>');
					}
					$('#varyResetBtn').click();
					//�趨"ȷ��"��ť��״̬Ϊ�ɱ༭״̬
					$('#submitBtn').removeAttr('disabled');
				}	  
			});
			//������������
			$('#varyResetBtn').click(function() {
				//�ֻ���������
				$('#sourcePhone').val('');
				$('#destPhone').val('');
				//��������
				$('#familyRoleTab input[name=sourcePhonePwd]').val('');
				$('#familyRoleTab input[name=destPhonePwd]').val('');
			});
			
			//�ύ��ť
			$('#submitBtn').click(function() {
				//�޶������û�б�����벻������ȷ��
				if(variedUserArr.length == 0) {
					rdShowMessageDialog('û�пɱ���ĺ��룡');	
					return false;
				}
				var length = resulFamUsertArr.length;
				var famRoles = resulFamUsertArr;
				var create_accept = '<%=create_accept%>';
				var chnsource = '01';
				var opCode = '<%=opCode%>';
				var loginNo = '<%=work_no%>';
				var password = '<%=password%>';
				var phone_no_master = '<%=parentPhone%>';
				var op_note = '<%=work_no%>����ͥ��Ա���';
				var prod_code = $('#familyProdInfo').val();
				var family_code = '<%=familyCode%>';
				var pay_money = '0';
				var sps = new Array();
				var dps = new Array();
				for(var i=0,len=variedUserArr.length;i<len;i++) {
					sps.push(variedUserArr[i].phone);
					dps.push(variedUserArr[i].afterPhone);	
				}
				var vary_source_phones = '';
				var vary_dest_phones = '';
				if(sps.length > 0) {
					vary_source_phones = sps.join(',');
				}
				if(dps.length > 0) {
					vary_dest_phones = dps.join(',');
				}
				$('#create_accept').val('<%=create_accept%>');
				var JSONText = JSON.stringify(new FamUsers(length,famRoles,create_accept,chnsource,opCode,loginNo,password,phone_no_master,op_note,prod_code,family_code,pay_money,vary_source_phones,vary_dest_phones),function(key,value){
					return value;
				});
				$('#myJson').val(JSONText);
				<%if(familyCode.equals("KDJT") || familyCode.equals("RHJT")){%>
							printCommit22('<%=opCode%>');
		  	<%}else {%>
				printCommit(opCode);
				<%}%>
			});
			$('#clearBtn').click(function() {
				window.location = 'fe280Vary.jsp?belongGroupId=<%=belongGroupId%>&familyCode=<%=familyCode%>&familyName=<%=familyName%>&opCode=<%=opCode%>&opName=<%=opName%>&parentPhone=<%=parentPhone%>';
			});
		});
		
		//TODO Ч���е��,���Ǵ����׶���
		function initRoleTbodyRefrech() {
			//���á���ͥ���г�Ա�б�
			$('#initRoleTbody').empty();
			var listTemp = new Array();
			for(var i=0,len=initUserArr.length;i<len;i++) {
				var _RoleUser = initUserArr[i];
				listTemp.push('<tr><td>' + _RoleUser.famCode + '</td>');
				listTemp.push('<td>' + _RoleUser.famName + '</td>');
				listTemp.push('<td>' + _RoleUser.phone + '</td>');
				listTemp.push('<td>' + _RoleUser.role + '</td>');
				listTemp.push('<td>' + _RoleUser.beginTime + '</td>');
				listTemp.push('<td>' + _RoleUser.endTime + '</td>');
				if(_RoleUser.editSts == '1') {
					listTemp.push('<td><input type="button" name="varyBtn" ');
					listTemp.push('onClick="getPhone(this);" diabled value="���" ');
					listTemp.push('id="' + _RoleUser.phone +'" disabled class="b_text"/></td></tr>');
				}else if(_RoleUser.editSts == '0') {
				if(_RoleUser.role=="�����ͥ�����Ա") {
					listTemp.push('<td><input type="button" name="varyBtn" ');
					listTemp.push('onClick="getPhone(this);" diabled value="���" ');
					listTemp.push('id="' + _RoleUser.phone +'" disabled class="b_text"/></td></tr>');
					}else {
					listTemp.push('<td><input type="button" name="varyBtn" ');
					listTemp.push('onClick="getPhone(this);" value="���" ');
					listTemp.push('id="' + _RoleUser.phone +'" class="b_text"/></td></tr>');
					}
				}
			}
			if(initUserArr.length > 0) {
				$('#initRoleTbody').append(listTemp.join(''));
			}
		}
		
		//������������ť��ʵ���õ�ǰ�е��ֻ���������ͥ��Ա������ġ�Դ�ֻ����롱
		function getPhone(k) {
			var v = k.parentNode.parentNode;
			var phone = $(v).find("td:eq(2)").text();
			$('#sourcePhone').val(phone);
			$('input[name="sourcePhonePwd"]').val('');
			//���á���ͥ��Ա������İ�ť�Ĳ��ɱ༭״̬
			setvarySubmitBtnDisabled();
			sourceSts = -1;//-1:��Ҫ��֤���룬0��û����֤���룻1����֤����
			sourceOrDest = -1;//��֤�ĸ��ֻ������룬0��source��1��dest
			
		}
		
		function delVariedRec(k) {
			var v = k.parentNode.parentNode;
			var sourcePhone = $(v).find("td:first").text();
			var destPhone= $(v).find("td").eq(1).text();
			var _user = variedUserArr.getElByValue(sourcePhone,"phone");
			
			//����Ǽ�ͥ�ڳ�Ա�������á���ͥ���г�Ա�б��Ĳ�����ť״̬
			if(_user && _user.exsitAfterPhone) {
			//	variedUserArr.removeElByValue(destPhone,"phone");
				$('#initRoleTbody').find('input[id="' + destPhone + '"]').removeAttr('disabled');
			}
			variedUserArr.removeElByValue(sourcePhone,"phone");
			//���á���ͥ���г�Ա�б��Ĳ�����ť״̬
			$('#initRoleTbody').find('input[id="' + sourcePhone + '"]').removeAttr('disabled');
			//ɾ��resulFamUsertArr�еļ�¼
			resulFamUsertArr.removeElsByValue(sourcePhone,'phone_no_subordinate');
			resulFamUsertArr.removeElsByValue(destPhone,'phone_no_subordinate');
			//ɾ�����ѱ����ɫ�����ļ�¼
			var tbody = v.parentNode;
			tbody.removeChild(v);	
			if(variedUserArr.length == 0) {
				$('#submitBtn').attr('disabled',true);
			}
		}
		
		//���Դ�ֻ������Ŀ���ֻ������Ƿ�ɱ��  
		function checkPhone(sourcePhone,destPhone) {
			//1. �ֻ��Ż������
			if(sourcePhone == '' || sourcePhone == null || destPhone == '' || destPhone == null ) {
				 rdShowMessageDialog("��ͥ��Ա������ֻ����붼����Ϊ�գ�");
				 return false;
			}else if(sourcePhone.length != 11 || destPhone.length != 11) {
				 rdShowMessageDialog("��ͥ��Ա������ֻ�����λ�����ԣ�");
				 return false;
			}
			//2. Դ�ֻ��ź�Ŀ���ֻ��Ų���һ��
			if(sourcePhone == destPhone ) {
				 rdShowMessageDialog("Դ�ֻ��Ų��ܺ�Ŀ���ֻ���һ�£�");
				 return false;
			}
			//3. Դ�ֻ����벻�ǿɱ���ļ�ͥ��Ա��ɫ
			if(!canVaryFamUser(sourcePhone)) {
				return false;
			};
			//4. Դ�ֻ����벻�����ѱ�������ֻ�����
			 if(judgeSourcePhoneVarid(sourcePhone)) {
			 	 rdShowMessageDialog("Դ�ֻ������Ѿ��������");
				 return false;
			 }
			 //5. Ŀ���ֻ������ǲ��ɱ���ļ�ͥ��Ա
			 if(judgeSourcePhoneVarid(sourcePhone)) {
			 	 rdShowMessageDialog("Դ�ֻ������Ѿ��������");
				 return false;
			 }
			 
			//5. Ŀ���ֻ������ѱ����
			 if(judgeDestPhoneUsed(destPhone)) {
			 	 rdShowMessageDialog("Ŀ���ֻ������Ѿ��������");
				 return false;
			 }
			 //6. ͬ��ɫ��������
			 var _el = initUserArr.getElByValue(destPhone,"phone");
			 var _el2 = initUserArr.getElByValue(sourcePhone,"phone");
			 if( _el != -1 && _el != '-1' && _el2 != -1 && _el2 != '-1') {
			 	if(_el.role == _el2.role) {
			 		rdShowMessageDialog("ͬ��ɫ�ֻ����벻��������");
				 	return false;	
			 	}
			 } 
 			//7. �Ƿ�ͨ������У��
			getPubCheck();
			
			if($("#checkStatus").val() == "1"){
				return true;
			}else {
				return false;
			}
		}
		
		/*
		 *	�ж�Դ�ֻ������Ƿ��ǿɱ���ļ�ͥ��Ա��ɫ
		 *	���flag��false������ʾdialog
		 */
		function canVaryFamUser(phone) {
			//1. ��ͥ��Ա
			if(judgePhoneExsit(phone)) {
				//2. ����Ǽ�ͥ��Ա���ɱ��
				var _user = initUserArr.getElByValue(phone,"phone");
				if(_user.editSts == '0') {
					return true;	
				}else {
					rdShowMessageDialog("Դ�ֻ������ǲ��ɱ���ļ�ͥ��Ա�ֻ����룡");
					return false;	
				}
			}else {
					rdShowMessageDialog("Դ�ֻ����벻�Ǽ�ͥ��Ա�ֻ����룡");
					return false;	
			}
		}
		
		function getPubCheck(){
			var json = new Array();
			json.push('iFamCode=');
			json.push('<%=familyCode%>');
			json.push('   iProdCode=' + $('#familyProdInfo').val());
			var getdataPacket = new AJAXPacket("fe280VaryCheck.jsp","���ڻ�����ݣ����Ժ�......");
			getdataPacket.data.add("sourcePhone",$('#sourcePhone').val());
			getdataPacket.data.add("destPhone",$('#destPhone').val());
			getdataPacket.data.add("sourcePwd",$('input[name=sourcePhonePwd]').val());
			getdataPacket.data.add("opCode",'<%=opCode%>');
			getdataPacket.data.add("famCode",'<%=familyCode%>');
			getdataPacket.data.add("prodCode",$('#familyProdInfo').val());
			core.ajax.sendPacket(getdataPacket,doPubCheckBack);
			getdataPacket = null;
		}
		function doPubCheckBack(packet){
			var ret_code = packet.data.findValueByName("retcode");
			var ret_msg = packet.data.findValueByName("retmsg");
			var chgFlag = packet.data.findValueByName("chgFlag");
			if(ret_code != "000000"){
				$("#checkStatus").val("0");
				rdShowMessageDialog(ret_msg,0);
		  		return false;
			}else{
				if(chgFlag == '1') {
					rdShowMessageDialog(ret_msg);
					return false;
				}else if(chgFlag == '0') {
					$("#checkStatus").val("1");
					//1. �жϵ�ǰFamUser�ı�ʶλ��3�������ǰ�棬1�������
					for(var i=0,len=tempFamUserArray.length;i<len;i++) {
						var user = tempFamUserArray[i];
						for(var j=0,len2=user.businesses.length;j<len2;j++) {
							var busiEl = user.businesses[j];
							if(busiEl.exec_order == '1') {
								resulFamUsertArr.push(user);
							}else if(busiEl.exec_order == '3') {
								resulFamUsertArr.splice(0,0,user);	
							}
							break;
						}
					}				
					tempFamUserArray = [];
					return true;
				}else {
					return false;	
				}
				
			}
		}
		
		function printCommit(opCode){
			var ret = showPrtDlg(opCode,"ȷʵҪ���е��������ӡ��","Yes");
			if(typeof(ret)!="undefined"){
				if((ret=="confirm")){
					if(rdShowConfirmDialog('ȷ�ϵ��������')==1){
						frmCfm();
					}
				}
				if(ret=="continueSub"){
					if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
						frmCfm();
					}
				}
			}
			else{
				if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
					frmCfm();
				}
			}
			return true;
		}
								function printCommit22(opCode){
			var ret = showPrtDlg22(opCode,"ȷʵҪ���е��������ӡ��","Yes");
			if(typeof(ret)!="undefined"){
				if((ret=="confirm")){
					if(rdShowConfirmDialog('ȷ�ϵ��������')==1){
						frmCfm();
					}
				}
				if(ret=="continueSub"){
					if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
						frmCfm();
					}
				}
			}
			else{
				if(rdShowConfirmDialog('ȷ��Ҫ�ύ��Ϣ��')==1){
					frmCfm();
				}
			}
			return true;
		}
		function frmCfm(){
			form1.action="fe280VaryCfm.jsp";
			form1.submit();
		}
		function showPrtDlg(opcode,DlgMessage,submitCfm){
			//��ʾ��ӡ�Ի���
			var h=180;
			var w=350;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			
			var pType="subprint";                   //��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
			var billType="1";              			//Ʊ�����ͣ�1���������2��Ʊ��3�վ�
			var sysAccept ='<%=printAccept%>'; //��ˮ��
			
			var printStr = printInfo(opcode);		//����printinfo()���صĴ�ӡ����
			var mode_code=null;           			//�ʷѴ���
			var fav_code=null;                		//�ط�����
			var area_code=null;             		//С������
			var opCode=$("#opCode").val();          //��������
			/*��ͥ��ɢʱ����ӡ�����ˮ��ֵ*/
			if(opCode == "e284"){
				sysAccept = "<%=create_accept%>";
			}
			var phoneNo = '';  //�ͻ��绰
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+
				"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
			var path = $("#reqContextPath").val() + "/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage ;
			path += "&mode_code="+mode_code+
				"&fav_code="+fav_code+"&area_code="+area_code+
				"&opCode="+opCode+"&sysAccept="+sysAccept+
				"&phoneNo="+phoneNo+
				"&submitCfm="+submitCfm+"&pType="+
				pType+"&billType="+billType+ "&printInfo=" + printStr;
			
			var ret=window.showModalDialog(path,printStr,prop);
			return ret;
		}
				function showPrtDlg22(opcode,DlgMessage,submitCfm){
			//��ʾ��ӡ�Ի���
			var h=180;
			var w=350;
			var t=screen.availHeight/2-h/2;
			var l=screen.availWidth/2-w/2;
			
			var pType="subprint";                   //��ӡ���ͣ�print ��ӡ subprint �ϲ���ӡ
			var billType="1";              			//Ʊ�����ͣ�1���������2��Ʊ��3�վ�
			var sysAccept ='<%=printAccept%>'; //��ˮ��
			var printStr = printInfo22(opcode);		//����printinfo()���صĴ�ӡ����
			var mode_code=null;           			//�ʷѴ���
			var fav_code=null;                		//�ط�����
			var area_code=null;             		//С������
			var opCode=$("#opCode").val();          //��������
			/*��ͥ��ɢʱ����ӡ�����ˮ��ֵ*/
			if(opCode == "e284"){
				sysAccept = "<%=create_accept%>";
			}
			var phoneNo = '';  //�ͻ��绰
			var prop="dialogHeight:"+h+"px; dialogWidth:"+w+"px; dialogLeft:"+l+"px; dialogTop:"+t+
				"px;toolbar:no; menubar:no; scrollbars:yes; resizable:no;location:no;status:no;help:no";
			var path = $("#reqContextPath").val() + "/npage/innet/hljBillPrint_jc_hw.jsp?DlgMsg=" + DlgMessage ;
			path += "&mode_code="+mode_code+
				"&fav_code="+fav_code+"&area_code="+area_code+
				"&opCode="+opCode+"&sysAccept="+sysAccept+
				"&phoneNo="+phoneNo+
				"&submitCfm="+submitCfm+"&pType="+
				pType+"&billType="+billType+ "&printInfo=" + printStr;
			
			var ret=window.showModalDialog(path,printStr,prop);
			return ret;
		}
		function printInfo(opcode){
			var cust_info="";
			var opr_info="";
			var note_info1="";
			var note_info2="";
			var note_info3="";
			var note_info4="";
			
			var retInfo = "";
			
			/************�ͻ���Ϣ************/
			cust_info += "�ֻ����룺" + $("#parentPhone").val() + "|";
			cust_info += "�ͻ�������"+$("#custName").val()+"|";
			/************��������************/
			opr_info += "�û�Ʒ�ƣ�" + $("#smName").val() + "  ����ҵ��" + '<%=printName%>' +"|";
			opr_info += "������ˮ��<%=printAccept%>  ҵ�����ʱ�䣺" + '<%=cccTime%>' +"|";
			opr_info += "��ͥ�˾�ͨ�̻����룺" + $("#parentPhone").val() + "|";
			//��ͥ�ڻ������ºű���ϲ���һ��
			opr_info += getPrint();
			/************ע������************/
			note_info1 += "��ע��" + "|";
			note_info1 += "ע�����" + "|";
			note_info1 += "1��ԭ��Ա�ʷ���Ч�������µף�|";
			note_info1 += "2���³�Ա�����ʷ��Ż�������1����ʱ��Ч��|";
			note_info1 += "3��ÿ�½�������һ�Σ�ÿ�ν�������һ������|";
			retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
			return retInfo;
		}
				function printInfo22(opcode){
			var cust_info="";
			var opr_info="";
			var note_info1="";
			var note_info2="";
			var note_info3="";
			var note_info4="";


		 qryoffer(offeriddd1);
		 qryoffer1(offeriddd2);
			var retInfo = "";
			
			/************�ͻ���Ϣ************/
			cust_info += "�ֻ����룺" + $("#parentPhone").val() + "|";
			cust_info += "�ͻ�������"+$("#custName").val()+"|";
			/************��������************/
			opr_info += "�û�Ʒ�ƣ�" + $("#smName").val() + "  ����ҵ��<%=printOpName %>�ʷѳ�Ա���"  +"|";
			opr_info += "������ˮ��<%=printAccept%>  ҵ�����ʱ�䣺" + '<%=cccTime%>' +"|";
			opr_info += "<%=printOpName %>�ҳ�����: " + $("#parentPhone").val() + "|";
			//��ͥ�ڻ������ºű���ϲ���һ��
			opr_info += getPrint();
			var zifeim1111 =document.all.offername11.value;
			var zifeimsss1111 =document.all.offercomments11.value;
			var zifeim2222 =document.all.offername22.value;
			var zifeimsss2222 =document.all.offercomments22.value;
			if(zifeim1111 !="") { 
			opr_info+="ָ���ʷѣ�"+zifeim1111+"|";
			opr_info+="ָ���ʷ�������"+zifeimsss1111+"|";
			}
						if(zifeim2222 !="") { 
			opr_info+="ָ���ʷѣ�"+zifeim2222+"|";
			opr_info+="ָ���ʷ�������"+zifeimsss2222+"|";
			}
			/************ע������************/
			note_info1 += "��ע��" + "|";
			note_info1 += "ע�����" + "|";
			note_info1 += "1��ԭ��Ա�ʷ���Ч�������µף�|";
			note_info1 += "2���³�Ա�����ʷ��Ż�������1����ʱ��Ч��|";
			note_info1 += "3��ÿ�½�������һ�Σ�ÿ�ν�������һ������|";
			retInfo = strcat(cust_info,opr_info,note_info1,note_info2,note_info3,note_info4);
			retInfo=retInfo.replace(new RegExp("#","gm"),"%23");
			return retInfo;
		}
		function qryoffer(offerid) {
				if(offerid !="") {
						var getdataPacket = new AJAXPacket("fe280Vary_qryoffers.jsp","�����ύ�У����Ժ�......");
				getdataPacket.data.add("offerid",offerid);	
				core.ajax.sendPacket(getdataPacket,checkSMZValue1);								

				}
		}
						  function checkSMZValue1(packet) {
		      document.all.offername11.value="";
		      document.all.offercomments11.value="";
		      var offername11 = packet.data.findValueByName("offername");
					var offercomments11 = packet.data.findValueByName("offercomments");
		      document.all.offername11.value=offername11;
		      document.all.offercomments11.value=offercomments11;
		      
		}
				function qryoffer1(offerid) {
				if(offerid !="") {
						var getdataPacket = new AJAXPacket("fe280Vary_qryoffers.jsp","�����ύ�У����Ժ�......");
				getdataPacket.data.add("offerid",offerid);	
				core.ajax.sendPacket(getdataPacket,checkSMZValue11);								

				}
		}
						  function checkSMZValue11(packet) {
		      document.all.offername22.value="";
		      document.all.offercomments22.value="";
		      var offername11 = packet.data.findValueByName("offername");
					var offercomments11 = packet.data.findValueByName("offercomments");
		      document.all.offername22.value=offername11;
		      document.all.offercomments22.value=offercomments11;
		      
		}
		
		//ѭ��variedUserArr������������
		function getPrint() {
			var retArr = new Array();
			//��ͥ�ں��뻥��
			var oldMust = new Array(); 
			var oldNotMust = new Array();
			//������º���
			var oldUser = new Array();
			var newUser = new Array();
			for(var i=0,len=variedUserArr.length;i<len;i++) {
				var vu = variedUserArr[i];
				if(vu.exsitAfterPhone) {
					//��ͥ�ڻ���
					var phone = vu.phone;
					var oldPhone = initUserArr.getElByValue(phone,'phone');
					if(oldPhone.role == '��ѡ��Ա') {
						oldNotMust.push(oldPhone.phone);
						oldNotMust.push('  ');
						oldMust.push(vu.afterPhone);
						oldMust.push('  ');
					}else if(oldPhone.role == '��ѡ��Ա') {
						oldMust.push(oldPhone.phone);
						oldMust.push('  ');
						oldNotMust.push(vu.afterPhone);
						oldNotMust.push('  ');
					} 
				}else {
					//�����º���
					oldUser.push(vu.phone);
					oldUser.push('  ');
					newUser.push(vu.afterPhone);
					newUser.push(' ');
				}
			}
			if(oldUser.length > 0) {
				retArr.push('ԭ��ͥ��Ա�ֻ����룺' + oldUser.join('') + '|');
				retArr.push('������ͥ��Ա�ֻ����룺' + newUser.join('') + '|');
			}
			if(oldMust.length > 0) {
				retArr.push('ԭ��ͥ��ѡ��Ա�ֻ����룺' + oldMust.join('') + '���Ϊ��ѡ��Ա|');
				retArr.push('ԭ��ͥ��ѡ��Ա�ֻ����룺' + oldNotMust.join('') + '���Ϊ��ѡ��Ա|');
			}
			if(retArr.length > 0){
				return 	retArr.join('');
			}
			return "";
		}
		
		 function chkProductPwd(k){
		 	var v = k.parentNode;
		 	var p = v.parentNode;
		 	var $firInput = $(p).find("input:first");
	        var phone = $firInput.val();
	        var pwd = $(v).find("input:eq(0)").val();
	        if( $firInput.attr('id') == 'sourcePhone' ) {
	        	sourceOrDest = 0;
	        }else if( $firInput.attr('id') == 'destPhone' ) {
	        	sourceOrDest = 1;
	        }
	        var checkPwd_Packet = new AJAXPacket("<%=request.getContextPath()%>/npage/s7983/pubCheckPwd.jsp","���ڽ�������У�飬���Ժ�......");
	        checkPwd_Packet.data.add("retType","checkPwd");
	    	checkPwd_Packet.data.add("phone_no",phone);
	    	checkPwd_Packet.data.add("Pwd1",pwd);
	    	core.ajax.sendPacket(checkPwd_Packet);
	    	checkPwd_Packet = null;
	    }
	    
	    function doProcess(packet){
	        var retType = packet.data.findValueByName("retType");
	        var retCode = packet.data.findValueByName("retCode");
	        var retMessage=packet.data.findValueByName("retMessage");
	
			var backArrMsg = packet.data.findValueByName("backArrMsg");
			var backArrMsg1 = packet.data.findValueByName("backArrMsg1");
			var backArrMsg2=packet.data.findValueByName("backArrMsg2");
	        
	        self.status="";
	        if(retType == "checkPwd") //���ſͻ�����У��
	        {
	            if(retCode == "000000")
	            {
	                var retResult = packet.data.findValueByName("retResult");
	                if (retResult == "false") {
	                    rdShowMessageDialog("�û�����У��ʧ�ܣ����������룡",0);
	                    return false;	        	
	                } else {
	                	if(sourceOrDest == '0') {
	                		sourceSts = 1;
	                	}else if(sourceOrDest == '1') {
	                		destSts = 1;
	                	}
	                	//ֻ�е���������֤���룬���ܵ��ȷ��
	                	if(sourceSts == '1' && destSts == '1') {
	                		$('#varySubmitBtn').removeAttr('disabled');
	                	}
	                    rdShowMessageDialog("�û�����У��ɹ���",2);
	                    
	                }
	            }
	            else
	            {
	                rdShowMessageDialog("�û�����У�����������У�飡",0);
	                return false;
	            }
	        }
	        else{
	            rdShowMessageDialog("������룺"+retCode+"������Ϣ��"+retMessage+"",0);
	            return false;
	        }
	    }
	    
	    //����"��ͥ��Ա���"��ťΪ���ɵ��״̬
	    function setvarySubmitBtnDisabled() {
	    	$('#varySubmitBtn').attr('disabled',true);
	    }
	    
	    function setDestSts(k) {
	    	if(k == '0') {
	    		sourceSts = -1;
	    	}else if(k == '1') {
	    		destSts = -1;	
	    	}
	    	setvarySubmitBtnDisabled();
	    }
	    
	    function doPubGetInfoBack(packet){
			var retCode = packet.data.findValueByName("retcode");
			var retMsg = packet.data.findValueByName("retmsg");
			var custName = packet.data.findValueByName("custName");
			var smName = packet.data.findValueByName("smName");
			$("#custName").val(custName);
			$("#smName").val(smName);
			
		}
	</script>
</head>
<body>
<form action="" method="post" name="form1">
		<%@ include file="/npage/include/header.jsp" %>
		<%@ include file="/npage/common/pwd_comm.jsp" %>
	<div class="title">
		<div id="title_zi">��ͥ��Ʒ���</div>
	</div>
	<table cellspacing="0">
		<tr>
			<td class="blue">��ͥ��Ʒ��Ϣ</td>
			<td>
				<select id="familyProdInfo" name="familyProdInfo" >
					<option value ="">--��ѡ��--</option>
					<wtc:qoption name="TlsPubSelCrm" outnum="2">
						<wtc:sql>
							SELECT prod_code, prod_name
							  FROM sfamilyprodinfo
							 WHERE family_code = '?' AND GROUP_ID = '?'
						</wtc:sql>
						<wtc:param value="<%=familyCode%>"/>
						<wtc:param value="<%=belongGroupId%>"/>
					</wtc:qoption>
				</select>
			</td>
		</tr>
	</table>
	<div class="title" id="famMembListContent">
		<div id="title_zi">��ͥ���г�Ա�б�</div>
	</div>
	<table id="familyMemberList">
		<thead>
			<tr>
				<th>��ͥ����</th>
				<th>��ͥ����</th>
				<th>�ֻ�����</th>
				<th>��ɫ����</th>
				<th>��Чʱ��</th>
				<th>ʧЧʱ��</th>
				<th>����</th>
			</tr>
		</thead>
		<tbody id="initRoleTbody">
		</tbody>
				
	</table>
	<div id="items">
		<div class="item-col2 col-1">
			<div class="title" >
				<div id="title_zi">��ͥ��Ա���</div>
			</div>	
			<table cellspacing="0" id="familyRoleTab">
				<tr>
					<td class="blue">&nbsp;&nbsp;Դ�ֻ���</td>
					<td>
						<input type="text" id="sourcePhone" name="sourcePhone"  maxlength="11" 
							v_type="mobphone" v_must="1" 
							onkeyup="this.value=this.value.replace(/\D/g,'');setDestSts(0)" 
							onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
					</td>
					<td class="blue">����</td>
					<td>
						<jsp:include page="/npage/common/pwd_8.jsp">
			                <jsp:param name="width1" value="16%"  />
			                <jsp:param name="width2" value="34%"  />
			                <jsp:param name="pname" value="sourcePhonePwd"  />
			                <jsp:param name="pwd" value=""  />
			            </jsp:include>
			            <input type='button' class='b_text' name='chk_productPwd' onClick='chkProductPwd(this)' value='У��' />
			            <font class="orange">*</font>
					</td>
				</tr>
				<tr>
					<td class="blue">Ŀ���ֻ���</td>
					<td>
						<input type="text" id="destPhone" name="destPhone" maxlength="11" 
							v_type="mobphone" v_must="1" 
							onkeyup="this.value=this.value.replace(/\D/g,'');setDestSts(1);"
							onafterpaste="this.value=this.value.replace(/\D/g,'')"/>
					</td>
					<td class="blue">����</td>
					<td>
						<jsp:include page="/npage/common/pwd_8.jsp">
			                <jsp:param name="width1" value="16%"  />
			                <jsp:param name="width2" value="34%"  />
			                <jsp:param name="pname" value="destPhonePwd"  />
			                <jsp:param name="pwd" value=""  />
			            </jsp:include>
			            <input type='button' class='b_text' name='chk_productPwd' onClick='chkProductPwd(this)' value='У��' />
			            <font class="orange">*</font>
					</td>
				</tr>
			</table>
			<table>
				<tr>
					<td align="center">
						<input type="button" class="b_foot" value="ȷ��" id="varySubmitBtn" name="varySubmitBtn">
						&nbsp;&nbsp;&nbsp;
						<input type="button" class="b_foot" value="����" id="varyResetBtn" name="varyResetBtn">
					</td>
				</tr>
			</table>
		</div>
		
		<div class="item-row2 col-2">
			<div class="title" >
				<div id="title_zi">�ѱ����Ա��</div>
			</div>	
			<table cellspacing="0" id="addRoleTab">
				<tr>
					<th width="25%">Դ�ֻ�����</th>
				<!--	<th>��ɫ����</th> -->
					<th>Ŀ���ֻ�����</th>
					<th>����</th>
				</tr>
				<tbody id="variedRoleListTb">
				</tbody>
			</table>
		</div>
	</div>
	
	<input type="hidden" value="" id="checkStatus" /><!-- 0��������1���쳣 -->
	<!-- �����Ҫ�Ĳ��� begin-->
	<input type="hidden" id="reqContextPath" value="<%=request.getContextPath()%>" />
	<input type="hidden" id="printAccept" value="" />
	<input type="hidden" name="custName" id="custName" value=""/>
	<input type="hidden" name="smName" id="smName" value=""/>
	<!-- �����Ҫ�Ĳ��� end-->
	<!-- ��Ҫ���ݵĲ��� begin-->
	<input type="hidden" value="" id="myJson" name="myJson" /> 
	<input type="hidden" value="" id="opCode" name="opCode" />
	<input type="hidden" value="" id="opName" name="opName" />
	<input type="hidden" value="" id="create_accept" name="create_accept" />
	<input type="hidden" value="" id="parentPhone" name="parentPhone" />
	<input type="hidden" value="" id="offername11" name="offername11" />
	<input type="hidden" value="" id="offercomments11" name="offercomments11" />
		<input type="hidden" value="" id="offername22" name="offername22" />
	<input type="hidden" value="" id="offercomments22" name="offercomments22" />


	<!-- ��Ҫ���ݵĲ��� end-->
	
	<table>
		<tr> 
			<td id="footer"> <div align="center"> 
			<input name="submitBtn" id="submitBtn" type="button" disabled class="b_foot" value="ȷ��" />
			&nbsp; 
			<input name="reset" id="clearBtn" type="button" class="b_foot" value="���" />
			&nbsp; 
			<input name="reset" type="button" class="b_foot" value="����" onclick="goBack()" />
			&nbsp; 
			<input name="back" onClick="removeCurrentTab();" type="button" class="b_foot" value="�ر�" />
			&nbsp; </div>
			</td>
		</tr>
	</table>
	<%@ include file="/npage/include/footer.jsp" %> 
</form>
<%@ include file="/npage/include/pubLightBox.jsp" %>
</body>
</html>


<script>
	function goBack(){
		location="fe280.jsp?activePhone=<%=parentPhone%>";
	}
</script>
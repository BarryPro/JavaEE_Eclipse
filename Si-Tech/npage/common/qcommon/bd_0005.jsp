<%
/*
 * ����: �ͻ�������ϸ��Ϣ
 * �汾: v1.0
 * ����: 2009/01/19
 * ����: wanglj
 * ��Ȩ: sitech
 * �޸���ʷ
 * �޸�����      �޸���      �޸�Ŀ��
 */
%> 
<div id="operation">	 	 
 	<div id="operation_table">
 		<div class="title"><div class="text">������Ϣ</div></div>
		<div class="input">	
			<table>
				<tr>
					<th>������ţ�</th>
					<td>
							<input type="text" class="required" name="order_no" />
					</td>
					<th>�������:</th>
					<td><input type="text" class="required" name="service_phoneNo" /></td>
				</tr>
				<tr>
					<th>ҵ�����ͣ�</th>
					<td>
							<input type="text" class="required email" name="service_type"/>
					</td>
					<th>����ʱ��:</th>
					<td><input type="text" name="order_beginTime" /></td>
				</tr>
				<tr>
					<th>��ǰ״̬��</th>
					<td>
							<input type="text"  name="curr_status"/>
					</td>
					<th>״̬ʱ��:</th>
					<td><input type="text" name="status_time" /></td>
				</tr>
				<tr>
					<th>�������ȼ���</th>
					<td>
							<input type="text" name="order_pri" />
					</td>
					<th>������Դ:</th>
					<td><input type="text" name="order_source" /></td>
				</tr>	
				<tr>
					<th>��������ʱ�䣺</th>
					<td>
							<input type="text"  name="order_endTime" />
					</td>
					<th>ҵ������ص�:</th>
					<td><input type="text" class="required" name="order_beginZone" /></td>
				</tr>
			</table>
		</div>
		<div class="title"><div class="text">��������Ϣ</div></div>
			<div class="input">	
			<table>				
				<tr>
					<th>���������ƣ�</th>
					<td>
							<input type="text"   name="order_name"/>
					</td>
					<th>ҵ���������:</th>
					<td><input type="text"  name="order_objType" /></td>
				</tr>
				<tr>
					<th>����Ʒ���ƣ�</th>
					<td>
							<input type="text"   name="sale_name"/>
					</td>
					<th>����״̬:</th>
					<td><input type="text" name="handle_status" /></td>
				</tr>
				<tr>
					<th>�Ƿ�Ԥ����</th>
					<td>
							<input type="text" name="is_preHandle" />
					</td>					 
				</tr>			 
			</table>
		</div>
		<div class="title"><div class="text">��������Ϣ</div></div>
			<div class="input">	
			<table>
				<tr>
					<th>���������ƣ�</th>
					<td>
							<input type="text" name="handle_name" />
					</td>
					<th>������֤������:</th>
					<td><input type="text" name="handle_iccdType" /></td>
				</tr>
				<tr>
					<th> ������֤�����룺</th>
					<td>
							<input type="text" name="handle_iccdNo" />
					</td>
					<th>��������ϵ�绰:</th>
					<td><input type="text" name="handle_phone" /></td>
				</tr>				 			 
			</table>
		</div> 
		<div class="title"><div class="text">��ע</div></div>
			<div class="input">	
			<table>
				<tr>
					<th>ϵͳ��ע��</th>
					<td>
							<input type="text" name="SysNote" />
					</td>
				</tr>
				<tr>
					<th>�û���ע:</th>
					<td><input type="text" name="OpNote" /></td>
				</tr>				 			 
			</table>
		     </div>
       </div> 
</div>
 



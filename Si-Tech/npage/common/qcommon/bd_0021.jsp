　
 <%@ page import="com.sitech.crmpd.core.wtc.utype.UType"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UtypeUtil"%>
<%@ page import="com.sitech.crmpd.core.wtc.utype.UElement"%>
 
<div id="operation"> 	 
 	<div id="operation_table">
 		<div class="title"><div class="text">用户基本信息</div></div>
		<div class="input">	
			<table>
				<tr>
					<th>用户名：</th>
					<td>
							<input type="text" class="required" />
					</td>
					<th>联系人:</th>
					<td><input type="text" name="cust_status" /></td>
				</tr>
				<tr>
					<th>联系电话：</th>
					<td>
							<input type="text" name="cust_owner"/>
					</td>
					<th>区域:</th>
					<td><input type="text" name="cust_level" /></td>
				</tr>
				<tr>
					<th>用户级别：</th>
					<td>
							<input type="text"  name="cust_type"/>
					</td>
					<th>住宅性质:</th>
					<td><input type="text" name="iccd_type"/></td>
				</tr>
				<tr>
					<th>用户密码：</th>
					<td>
							<input type="password" name="iccd_no" />
					</td>
					<th>预约服务时间:</th>
					<td><input type="text" name="cust_addr" /></td>
				</tr>				 
	 
				<tr>
					<th>信用度等级：</th>
					<td>
							<input type="text" name="contactor" />
					</td>
					<th>信用度值:</th>
					<td><input type="text" name="contact_iccdType" /></td>
				</tr>
				<tr>
					<th> 信用控制：</th>
					<td>
							<input type="text" name="contact_iccdNo" />
					</td>
					<th>透支额度:</th>
					<td><input type="text" name="contact_phone" /></td>
				</tr>
				<tr>
					<th>完成期限：</th>
					<td>
							<input type="text" name="contact_mobile" />
					</td>
					<th>预警时间:</th>
					<td><input type="text" name="contact_addr" /></td>
				</tr>
				<tr>
					<th>处理级别：</th>
					<td>
							<input type="text" name="contact_zip" />
					</td> 
				</tr>				 
			</table>
		</div> 		 
	     </div>
     </div>
 



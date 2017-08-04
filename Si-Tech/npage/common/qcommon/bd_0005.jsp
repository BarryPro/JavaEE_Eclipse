<%
/*
 * 功能: 客户订单详细信息
 * 版本: v1.0
 * 日期: 2009/01/19
 * 作者: wanglj
 * 版权: sitech
 * 修改历史
 * 修改日期      修改人      修改目的
 */
%> 
<div id="operation">	 	 
 	<div id="operation_table">
 		<div class="title"><div class="text">基本信息</div></div>
		<div class="input">	
			<table>
				<tr>
					<th>订单编号：</th>
					<td>
							<input type="text" class="required" name="order_no" />
					</td>
					<th>服务号码:</th>
					<td><input type="text" class="required" name="service_phoneNo" /></td>
				</tr>
				<tr>
					<th>业务类型：</th>
					<td>
							<input type="text" class="required email" name="service_type"/>
					</td>
					<th>创建时间:</th>
					<td><input type="text" name="order_beginTime" /></td>
				</tr>
				<tr>
					<th>当前状态：</th>
					<td>
							<input type="text"  name="curr_status"/>
					</td>
					<th>状态时间:</th>
					<td><input type="text" name="status_time" /></td>
				</tr>
				<tr>
					<th>订单优先级：</th>
					<td>
							<input type="text" name="order_pri" />
					</td>
					<th>订单来源:</th>
					<td><input type="text" name="order_source" /></td>
				</tr>	
				<tr>
					<th>订单竣工时间：</th>
					<td>
							<input type="text"  name="order_endTime" />
					</td>
					<th>业务受理地点:</th>
					<td><input type="text" class="required" name="order_beginZone" /></td>
				</tr>
			</table>
		</div>
		<div class="title"><div class="text">订单项信息</div></div>
			<div class="input">	
			<table>				
				<tr>
					<th>订单项名称：</th>
					<td>
							<input type="text"   name="order_name"/>
					</td>
					<th>业务对象类型:</th>
					<td><input type="text"  name="order_objType" /></td>
				</tr>
				<tr>
					<th>销售品名称：</th>
					<td>
							<input type="text"   name="sale_name"/>
					</td>
					<th>受理状态:</th>
					<td><input type="text" name="handle_status" /></td>
				</tr>
				<tr>
					<th>是否预受理：</th>
					<td>
							<input type="text" name="is_preHandle" />
					</td>					 
				</tr>			 
			</table>
		</div>
		<div class="title"><div class="text">经办人信息</div></div>
			<div class="input">	
			<table>
				<tr>
					<th>经办人名称：</th>
					<td>
							<input type="text" name="handle_name" />
					</td>
					<th>经办人证件类型:</th>
					<td><input type="text" name="handle_iccdType" /></td>
				</tr>
				<tr>
					<th> 经办人证件号码：</th>
					<td>
							<input type="text" name="handle_iccdNo" />
					</td>
					<th>经办人联系电话:</th>
					<td><input type="text" name="handle_phone" /></td>
				</tr>				 			 
			</table>
		</div> 
		<div class="title"><div class="text">备注</div></div>
			<div class="input">	
			<table>
				<tr>
					<th>系统备注：</th>
					<td>
							<input type="text" name="SysNote" />
					</td>
				</tr>
				<tr>
					<th>用户备注:</th>
					<td><input type="text" name="OpNote" /></td>
				</tr>				 			 
			</table>
		     </div>
       </div> 
</div>
 



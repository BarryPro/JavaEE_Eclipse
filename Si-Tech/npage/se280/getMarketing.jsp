<%@ page contentType= "text/html;charset=gb2312" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String opCode = request.getParameter("opCode");
	String parentPhone = request.getParameter("parentPhone");
	
	String famCode = request.getParameter("famCode");
	String prodCode = request.getParameter("prodCode");
	String famRole = request.getParameter("famRole");
	String busiType = request.getParameter("busiType");
	String memRoleId = request.getParameter("memRoleId");
	System.out.println("getBusi.jsp-----[" + famCode + "|" + prodCode + "|" + famRole + "|" + memRoleId + "]");
	String work_no = (String)session.getAttribute("workNo");
  String regionCode= (String)session.getAttribute("regCode");
  String password = (String)session.getAttribute("password");
	
%>
		<wtc:service name="sFamSelCheck" routerKey="region" 
			 routerValue="<%=regionCode%>"  retcode="retCode1" retmsg="retMsg1" outnum="8">
				<wtc:param value=""/>
				<wtc:param value="01"/>
				<wtc:param value="<%=opCode%>"/>
				<wtc:param value="<%=work_no%>"/>
				<wtc:param value="<%=password%>"/>
				<wtc:param value="<%=parentPhone%>"/>
				<wtc:param value=""/>
				<wtc:param value="1"/>
				<wtc:param value="<%=famCode%>"/>
				<wtc:param value="<%=prodCode%>"/>
				<wtc:param value="<%=famRole%>"/>
				<wtc:param value="<%=memRoleId%>"/>
				<wtc:param value="<%=busiType%>"/>
		</wtc:service>
		<wtc:array id="result" scope="end"/>
<%
		System.out.println("---------getOfferContent.jsp--------" + retCode1);
		if("000000".equals(retCode1)){
			System.out.println("---------getOfferContent.jsp--------length" + result.length);

		String saleType = result[0][1];
		String busiId = result[0][0];
		
%>
			
		<tr>
			<td id="marketingTd" class="blue" rowspan="5">
				营销案
				<input type="hidden" id="marketingBusiId" value="<%=busiId%>" />
				<input type="hidden" id="marketSaleType" value="<%=saleType%>" />
			</td>
			<td class="blue">
				固话品牌
			</td>
			<td>
				<select id="brand" v_name="固话品牌" onchange="changeBrand('<%=saleType%>')">
					<option value ="">--请选择--</option>
					<wtc:qoption name="TlsPubSelCrm" outnum="2">
						<wtc:sql>
							SELECT UNIQUE a.brand_code, TRIM (b.brand_name)
			         FROM dphonesalecode a, schnresbrand b
			        WHERE a.region_code = '?'
			          AND a.sale_type = '?'
			          AND a.brand_code = b.brand_code
			          AND a.valid_flag = 'Y'
						</wtc:sql>
						<wtc:param value="<%=regionCode%>"/>
						<wtc:param value="<%=saleType%>"/>
					</wtc:qoption>
				</select>
			</td>
			<td class="blue">固话型号</td>
			<td>
				<select id="res" v_name="固话型号" onchange="changeRes('<%=saleType%>')">
				</select>
			</td>
		</tr>
		<tr>
			<td class="blue">营销案</td>
			<td>
				<select id="market" v_name="营销案" onchange="changeMarketing('<%=saleType%>')">
					<option value ="" prepayfee="" consume="" base_fee="" free_fee="" active_term="">--请选择--</option>
				</select>
			</td>
			<td class="blue">主资费</td>
			<td>
				<select id="mainOffer" v_name="主资费" onchange="changeMainOffer(this,'1')">
					<option value ="">--请选择--</option>
				</select>
			</td>
		</tr>
		<tr id="OfferAttribute" ></tr><!--小区代码-->
		<tr>
			<td class="blue">IMEI码</td>
			<td>
				<input name="IMEINo" id="IMEINo" type="text" v_type="0_9" v_name="IMEI码"  maxlength=15 value="" />
				<input name="checkimei" class="b_text" type="button" value="校验" onclick="checkimeino()">
        <font class='orange'>*</font>
			</td>
			<td class="blue">是否赠机</td>
			<td>
				<input type="checkbox" id="saleFlag" checked disabled />赠机
			</td>
		</tr>
		<tr>
			<td class="blue">预存</td>
			<td>
				<input type="text" name="prepayFee" id="prepayFee" readonly class="InputGrey" />
			</td>
			<td class="blue">消费期限</td>
			<td>
				<input type="text" name="consumeTerm" id="consumeTerm" readonly class="InputGrey" />
			</td>
		</tr>
		<tr >
			<td class="blue">底线预存</td>
			<td>
				<input type="text" name="base_fee" id="base_fee" readonly class="InputGrey" />
			</td>
			<td class="blue">活动预存</td>
			<td>
				<input type="text" name="free_fee" id="free_fee" readonly class="InputGrey" />
			</td>
		</tr>
		<tr style="display:none">
			<td class="blue">活动消费期限</td>
			<td colspan="3">
				<input type="text" name="active_term" id="active_term" readonly class="InputGrey" />
			</td>
		</tr>
		<tr >
			<td class="blue">购机款</td>
			<td>
				<input type="text" name="baseFeeHidd" id="baseFeeHidd" readonly class="InputGrey" />
			</td>
			<td class="blue">一次性返还金额</td>
			<td>
				<input type="text" name="freeFeeHidd" id="freeFeeHidd" readonly class="InputGrey" />
			</td>
		</tr>
				<tr >
			<td class="blue">按月返还金额</td>
			<td>
				<input type="text" name="monBaseFeeHidd" id="monBaseFeeHidd" readonly class="InputGrey" />
			</td>
			<td class="blue">返还月份</td>
			<td>
				<input type="text" name="activeTermeHidd" id="activeTermeHidd" readonly class="InputGrey" />
			</td>
		</tr>
<%
	}
%>

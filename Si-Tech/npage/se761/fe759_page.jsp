<%
  /* *********************
   * ����: �ʷѸ�������ҳ��
   * �汾: 1.0
   * ����: 2012-4-10 17:51:38
   * ����: ningtn
   * ��Ȩ: si-tech
   * *********************/
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	System.out.println("========= ningtn in fe759_page =====");
	String opCode = request.getParameter("opCode");
	String phoneNo = request.getParameter("phoneNo");
	/* ��Ʒ���ʶ ��Ʒ���ʶ(��Ʒ��ƴ����A#B# ������#�Ž�β) */
	String productLib = request.getParameter("productLib");
	/* ��Ʒ����(��Ʒ����ƴ����C#D# ������#�Ž�β ) */
	String productType = request.getParameter("productType");
	/* ������ʶ(ǰ̨ѡ���ޣ���BX) */
	String condition = request.getParameter("condition");
	/* �����ʶ(�����Ľ���0������������1 �۸�Ľ���2���۸������3) */
	String sortFlag = request.getParameter("sortFlag");
	/* ҳ�� */
	String pageNumStr = request.getParameter("pageNum");
	/* ÿҳ�������̶���ֵ20�� */
	String recordNum = request.getParameter("recordNum");
	/* ��׼����� */
	String normOfferId = request.getParameter("normOfferId");
	
	String workNo = (String)session.getAttribute("workNo");
	String password = (String)session.getAttribute("password");
  String regionCode= (String)session.getAttribute("regCode");
	
	String loginAccept = "";
	
	/*���÷����ý��*/
	System.out.println("========= ningtn fe759_page.jsp ====productLib " + productLib);
	System.out.println("========= ningtn fe759_page.jsp ====productType " + productType);
	System.out.println("========= ningtn fe759_page.jsp ====condition " + condition);
	System.out.println("========= ningtn fe759_page.jsp ====sortFlag " + sortFlag);
	System.out.println("========= ningtn fe759_page.jsp ====pageNumStr " + pageNumStr);
	System.out.println("========= ningtn fe759_page.jsp ====recordNum " + recordNum);
%>
		<wtc:service name="sProdOrderQry" routerKey="region" routerValue="<%=regionCode%>"
		  retcode="retCode" retmsg="retMsg" outnum="23">
			<wtc:param value=""/>
			<wtc:param value="01"/>
			<wtc:param value="<%=opCode%>"/>
			<wtc:param value="<%=workNo%>"/>
			<wtc:param value="<%=password%>"/>
			<wtc:param value="<%=phoneNo%>"/>
			<wtc:param value=""/>
			<wtc:param value="<%=productLib%>"/>
			<wtc:param value="<%=productType%>"/>
			<wtc:param value="<%=condition%>"/>
			<wtc:param value="<%=sortFlag%>"/>
			<wtc:param value="<%=pageNumStr%>"/>
			<wtc:param value="<%=recordNum%>"/>
			<wtc:param value="<%=normOfferId%>"/>
		</wtc:service>
		<wtc:array id="result" start="0" length="20" scope="end"/>
		<wtc:array id="result2" start="20" length="3" scope="end"/>
<%
	System.out.println("========= ningtn fe759_page.jsp ==== " + retCode + "|" + result.length);
	/*����*/
	String allPageNumStr = result2[0][1];
	String allProductNumStr = result2[0][2];
	System.out.println("===== ningtn fe759_page.jsp page==== " + allPageNumStr + "|" + allProductNumStr);
	int allPageNum = Integer.parseInt(allPageNumStr);
	int allProductNum = Integer.parseInt(allProductNumStr);
	int pageNum = Integer.parseInt(pageNumStr);
	/* ��ǰҳ�룬���Ҹ����༸�� */
	int lrNum = 2;
%>
		<table id = "tableSelect22" class="table-wrap"> 
			<tr>
				<th>
				ѡ��
				</th>
				<th>
				��Ʒ����
				</th>
				<th>
				��Ʒ����
				</th>
				<th>
				��Ʒ��Դ��
				</th>
				<th>
				��׼��
				</th>
				<th>
				�ۿۼ�
				</th>
				<th>
					��Чʱ��
				</th>
				<th>
					ʧЧʱ��
				</th>
				<th>
					��Ч��ʽ
				</th>
				<th>
				��������
				</th>
				<th>
				ʣ����
				</th>
				<th>
				��Ʒ����
				</th>
			</tr>
			<%
				for(int i = 0; i < result.length; i++){
			%>
			<tr>
				<td>
					<input type="checkbox" id="seachProdCheck_<%=result[i][17]%>" 
					 value="<%=result[i][17]%>" onclick="checkProd('<%=result[i][17]%>',1)"/>
				</td>
				<td>
					<span id="seachProdOfferName_<%=result[i][17]%>" title="<%=result[i][6]%>"><%=result[i][4]%></span>
					<input type="hidden" id="seachProdLib_<%=result[i][17]%>" value="<%=result[i][0]%>" />
					<input type="hidden" id="seachProdLibName_<%=result[i][17]%>" value="<%=result[i][1]%>" />
					<input type="hidden" id="seachProdOfferId_<%=result[i][17]%>" value="<%=result[i][3]%>" />
					<input type="hidden" id="seachProdDetailId_<%=result[i][17]%>" value="<%=result[i][17]%>" />
					<input type="hidden" id="seachProdOfferMin_<%=result[i][17]%>" value="<%=result[i][15]%>" />
					<input type="hidden" id="seachProdOfferMax_<%=result[i][17]%>" value="<%=result[i][16]%>" />
					<input type="hidden" id="seachProdType_<%=result[i][17]%>" value="<%=result[i][18]%>" />
					<input type="hidden" id="seachProdEffWay_<%=result[i][17]%>" value="<%=result[i][19]%>" />
				</td>
				<td>
					<%=result[i][1]%>
				</td>
				<td>
					<span id="seachProdSumRes_<%=result[i][17]%>"><%=result[i][9]%></span>
					<span id="seachProdResUnit_<%=result[i][17]%>"><%=result[i][10]%></span>
				</td>
				<td><span id="seachProdOriginalPrice_<%=result[i][17]%>"><%=result[i][7]%></span>Ԫ</td>
				<td>
					<%
					if(result[i][2] == null || "".equals(result[i][2])){
					}else{
					%>
					<span><%=result[i][2]%>��</span>
					<%
						}%>
					<span id="seachProdDiscountPrice_<%=result[i][17]%>"><%=result[i][8]%></span>Ԫ
				</td>
				<td><span id="seachProdBeginDate_<%=result[i][17]%>"><%=result[i][11]%></span></td>
				<td><span id="seachProdEndDate_<%=result[i][17]%>"><%=result[i][12]%></span></td>
				<td>
					<span>
						<%
							if(result[i][19].equals("0")){
								out.print("������Ч");
							}else if(result[i][19].equals("2")){
								out.print("�涨��Ч");
							}else if(result[i][19].equals("3")){
								out.print("ԤԼ��Ч");
							}
						%>
					</span>
				</td>
				<td><span><%=result[i][13]%></span></td>
				<td><span id="seachProdStock_<%=result[i][17]%>"><%=result[i][14]%></span></td>
				<td>
					<span title="<%=result[i][5]%>">
						<%
							if(result[i][5].length() < 20){
						%>
						<%=result[i][5]%>
						<%
							}else{
						%>
						<%=result[i][5].substring(0,20)%>...
						<%
							}
						%>
					</span>
				</td>
			</tr>
			<%
				}
			%>
		</table>
		<!---��ҳ����--->
		<div class="page-list">
			<ul>
				<li class="pageinfo">
					��
					<span><%=pageNum%></span>/<%=allPageNum%>ҳ
				</li>
				<%
					if(pageNum == 1){
						/*����ǵ�һҳ����һҳ�Ͳ��ʵ��*/
				%>
					<li class="unactive">
						&lt;&nbsp;��һҳ
					</li>
				<%
					}else{
				%>
					<li>
						<a onclick="goPage(<%=pageNum-1%>)">&lt;&nbsp;��һҳ</a>
					</li>
				<%
					}
				%>
				<%
					if(pageNum == 1){
				%>
					<li class="current">1</li>
				<%
					}else{
				%>
					<li>
						<a onclick="goPage(1)">1</a>
					</li>
				<%
					}
				%>
				<%
					if(pageNum > lrNum + 1){
				%>
					<li>...</li>
				<%
					}
				%>
				<%
					for(int i = pageNum - lrNum; i <= pageNum + lrNum ;i++){
						if(i > 1 && i < allPageNum){
							if(i != pageNum){
							%>
								<li><a onclick="goPage(<%=i%>)"><%=i%></a></li>
							<%
							}else{
							%>
								<li class="current"><%=i%></li>
							<%
							}
						}
					}
				%>
				<%
					if(pageNum < (allPageNum - (lrNum+1))){
				%>
					<li>...</li>
				<%
					}
				%>
				<%
					if(allPageNum > 1){
						if(pageNum == allPageNum){
				%>
						<li class="current"><%=allPageNum%></li>
				<%
						}else{
				%>
						<li>
							<a onclick="goPage(<%=allPageNum%>)"><%=allPageNum%></a>
						</li>
				<%
						}
					}
				%>
				
				<%
					if(pageNum ==allPageNum){
						/*��������һҳ����һҳ�Ͳ�������*/
				%>
					<li class="unactive">
						��һҳ&nbsp;&gt;
					</li>
				<%
					}else{
				%>
					<li>
						<a onclick="goPage(<%=pageNum+1%>)">��һҳ&nbsp;&gt;</a>
					</li>
				<%
					}
				%>

				<li>
					<input type="text" style="width: 25px;" class="text-style-page"
						title="����ֱ������ҳ��" id="pageText" v_type="0_9" onblur="checkElement(this)"
						onKeyDown="if(event.keyCode==13){ goPage(0);return false}" />
					<input type="hidden" id="allPageHide" value="<%=allPageNum%>"/>
					<input type="hidden" id="nowPageHide" value="<%=pageNum%>"/>
					<input type="button" value="GO" class="b_text" onclick="goPage(0)">
				</li>
			</ul>
		</div>
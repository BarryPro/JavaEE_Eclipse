
var excelObj;
function printTable(obj){
	var str = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
	total_row = 0;
	if(obj.length > 1)	{
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
 		//excelObj.WorkBooks.Add; 
		var workB = excelObj.Workbooks.Add(); ////添加新的工作簿   
		var sheet = workB.ActiveSheet;   
		sheet.Columns("A").numberformat="@";
		sheet.Columns("B").numberformat="@";
		sheet.Columns("C").numberformat="@";
		sheet.Columns("D").numberformat="@";
		sheet.Columns("E").numberformat="@";
		sheet.Columns("F").numberformat="@";
		sheet.Columns("G").numberformat="@";
		sheet.Columns("H").numberformat="@";
		sheet.Columns("I").numberformat="@";
		sheet.Columns("J").numberformat="@";
		for(a=0;a<obj.length;a++)
		{
			rows=obj[a].rows.length;
			if(rows>0)
			{
 				try
				{
					for(i=0;i<rows;i++)					{
						cells=obj[a].rows[i].cells.length;
						var g=0;
						for(j=0;j<cells;j++)
						{
							if(obj[a].rows[i].cells[j].colSpan > 1)
							{
							var colspan = obj[a].rows[i].cells[j].colSpan;
							for(g=0;g<colspan-1;g++)
								{
									excelObj.Cells(i+1+(total_row),1*g+1).Value='';
					            }
								g++;
					  		    excelObj.Cells(i+1+(total_row),g).Value=obj[a].rows[i].cells[j].innerText;
							}
							else
							{
							excelObj.Cells(i+1+(total_row),1*g+1).Value=obj[a].rows[i].cells[j].innerText;
							g++;
							}
						}
					}
				}
				catch(e)
				{
					alert('生成excel失败!');
				}
			}
			else
			{
				alert('no data');
 			}
 			total_row = eval(total_row+rows);
		}
	}
	else
	{
		excelObj = new ActiveXObject('excel.Application');
		excelObj.Visible = true;
 		//excelObj.WorkBooks.Add; 
 		var workB = excelObj.Workbooks.Add(); ////添加新的工作簿   
		var sheet = workB.ActiveSheet;   
		sheet.Columns("A").numberformat="@";
		sheet.Columns("B").numberformat="@";
		sheet.Columns("C").numberformat="@";
		sheet.Columns("D").numberformat="@";
		sheet.Columns("E").numberformat="@";
		sheet.Columns("F").numberformat="@";
		sheet.Columns("G").numberformat="@";
		sheet.Columns("H").numberformat="@";
		sheet.Columns("I").numberformat="@";
		sheet.Columns("J").numberformat="@";
		rows=obj.rows.length;
		if(rows>0)
		{
 			try
			{
				for(i=0;i<rows;i++)
				{
					cells=obj.rows[i].cells.length;
					var g=0;
					for(j=0;j<cells;j++)
					{
							if(obj.rows[i].cells[j].colSpan > 1)
							{
							var colspan = obj.rows[i].cells[j].colSpan;
							for(g=0;g<colspan-1;g++)
								{
									excelObj.Cells(i+1+(total_row),1*g+1).Value = '';
					            }
								g++;
					  		    excelObj.Cells(i+1+(total_row),g).Value=obj.rows[i].cells[j].innerText;
							}
							else
							{
							excelObj.Cells(i+1+(total_row),1*g+1).Value=obj.rows[i].cells[j].innerText;
							g++;
							}
					}
				}
			}
			catch(e)
			{
				alert('生成excel失败!');
			}
			total_row = eval(total_row+rows);
		}
		else
		{
			alert('no data');
		}
	}
	excelObj.Range('A1:'+str.charAt(cells+colspan-2)+total_row).Borders.LineStyle=1;
}


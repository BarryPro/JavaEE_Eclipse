package com.sitech.acctmgr.atom.dto.invoice.eleInvoice;
 
import com.sitech.acctmgr.common.dto.CommonOutDTO;
import com.sitech.jcfx.anno.ConsType;
import com.sitech.jcfx.anno.ParamDesc;
import com.sitech.jcfx.dt.MBean;


public class SEleInvoiceDownLoadOutDTO extends CommonOutDTO {
    
	private static final long serialVersionUID = -4423256470094740969L;

	@ParamDesc(path = "PDF_FILE", cons = ConsType.CT001, type = "string", len = "", desc = "发票PDF文件", memo = "略")
	private String pdfFile;

    @Override
    public MBean encode() {
        MBean result = super.encode();
        result.setRoot(getPathByProperName("pdfFile"), pdfFile);
        return result;
    }

    public String getPdfFile() {
        return pdfFile;
    }

    public void setPdfFile(String pdfFile) {
        this.pdfFile = pdfFile;
    }
}

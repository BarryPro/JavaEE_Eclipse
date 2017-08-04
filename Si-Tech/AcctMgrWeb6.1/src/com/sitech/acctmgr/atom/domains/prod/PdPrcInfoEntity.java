package com.sitech.acctmgr.atom.domains.prod;

/**
 * Created by wangyla on 2016/6/16.
 */
public class PdPrcInfoEntity {
    private String prodPrcName;
    private String prodPrcDesc;
    private String useRange;
    private String prodPrcId;
    private String prcType;

    public String getProdPrcName() {
        return prodPrcName;
    }

    public void setProdPrcName(String prodPrcName) {
        this.prodPrcName = prodPrcName;
    }

    public String getProdPrcDesc() {
        return prodPrcDesc;
    }

    public void setProdPrcDesc(String prodPrcDesc) {
        this.prodPrcDesc = prodPrcDesc;
    }

    public String getUseRange() {
        return useRange;
    }

    public void setUseRange(String useRange) {
        this.useRange = useRange;
    }

    public String getProdPrcId() {
        return prodPrcId;
    }

    public void setProdPrcId(String prodPrcId) {
        this.prodPrcId = prodPrcId;
    }

    public String getPrcType() {
		return prcType;
	}

	public void setPrcType(String prcType) {
		this.prcType = prcType;
	}

	@Override
    public String toString() {
        return "PdPrcInfoEntity{" +
                "prodPrcName='" + prodPrcName + '\'' +
                ", prodPrcDesc='" + prodPrcDesc + '\'' +
                ", useRange='" + useRange + '\'' +
                ", prodPrcId='" + prodPrcId + '\'' +
                ", prcType='" + prcType + '\'' +
                '}';
    }
}

package com.sitech.acctmgr.atom.impl.query;

import com.sitech.acctmgr.atom.domains.query.ProductOfferUpEntity;
import com.sitech.acctmgr.atom.dto.query.SProductOfferUpQueryInDTO;
import com.sitech.acctmgr.atom.dto.query.SProductOfferUpQueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IProd;
import com.sitech.acctmgr.atom.entity.inter.IUser;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.query.IProductOfferUp;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

@ParamTypes({
        @ParamType(c = SProductOfferUpQueryInDTO.class, oc = SProductOfferUpQueryOutDTO.class, m = "operate")})

public class SProductOfferUp extends AcctMgrBaseService implements IProductOfferUp {

    private IProd prod;
    private IUser user;

    @Override
    public OutDTO operate(InDTO inParam) {

        SProductOfferUpQueryInDTO inDTO = (SProductOfferUpQueryInDTO) inParam;
        log.debug("inDTO=" + inDTO.getMbean());

        String upId = inDTO.getUpId();
        String phoneNo = inDTO.getPhoneNo();
        int totalDate = inDTO.getTotalDate();
        String oprFlag = inDTO.getOprFlag();

        user.getUserEntityByPhoneNo(phoneNo, true);

        ProductOfferUpEntity prodOfferEnt = null;

        SProductOfferUpQueryOutDTO outDTO = new SProductOfferUpQueryOutDTO();

        if (oprFlag.equals("q")) {    //查询操作
            prodOfferEnt = prod.getProductUpInfo(upId, phoneNo, totalDate);

        } else if (oprFlag.equals("d")) {    //删除操作

            prod.saveProductOfferUpInfo(upId, phoneNo, totalDate);
            prod.delProductOfferUpInfo(upId, phoneNo, totalDate);
        }
        outDTO.setProdOfferEnt(prodOfferEnt);

        log.debug("outDTO=" + outDTO.toJson());
        return outDTO;
    }

    public IProd getProd() {
        return prod;
    }

    public void setProd(IProd prod) {
        this.prod = prod;
    }

    public IUser getUser() {
        return user;
    }

    public void setUser(IUser user) {
        this.user = user;
    }

}

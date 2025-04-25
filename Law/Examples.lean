/- 示例验证文件 -/
import Law.Legal

/- 示例验证 -/

-- 示例1：国有土地（自动识别为公共财产）
example : LegalProperty :=
  LegalProperty.public
    ⟨OwnerType.State, "国有土地", 1000, PropertyPurpose.General, none, {}, none, none, none, none, true⟩
    (by simp [isPublicProperty])

-- 示例2：国家机关管理的公民财产（视为公共财产）
example : LegalProperty :=
  LegalProperty.public
    ⟨OwnerType.Citizen, "扣押车辆", 50, PropertyPurpose.General, some ManagementInstitution.StateOrgan, { isManaged := true }, none, none, none, none, true⟩
    (by simp [isPublicProperty, isInSpecialState])

-- 示例3：个体工商户合法财产（识别为私有财产）
example : LegalProperty :=
  LegalProperty.private_property
    ⟨OwnerType.IndividualBusiness, "商铺设备", 20, PropertyPurpose.General, none, {}, none, none, none, none, true⟩
    (by simp [isPrivateProperty])

-- 示例4：用于扶贫的社会捐助财产（公共财产）
example : LegalProperty :=
  LegalProperty.public
    ⟨OwnerType.SocialDonation, "扶贫基金", 5000, PropertyPurpose.PovertyAlleviation, none, {}, none, none, none, none, true⟩
    (by simp [isPublicProperty])

-- 示例5：公民合法储蓄（私有财产）
example : LegalProperty :=
  LegalProperty.private_property
    ⟨OwnerType.Citizen, "银行存款", 10000, PropertyPurpose.General, none, {}, some CitizenPropertyType.Savings, none, none, none, true⟩
    (by simp [isPrivateProperty])

-- 示例6：家庭生产资料（私有财产）
example : LegalProperty :=
  LegalProperty.private_property
    ⟨OwnerType.Family, "家庭作坊机器", 3000, PropertyPurpose.General, none, {}, none, some ResourceType.ProductionResources, none, none, true⟩
    (by simp [isPrivateProperty])

-- 示例7：个人股票（私有财产）
example : LegalProperty :=
  LegalProperty.private_property
    ⟨OwnerType.Citizen, "上市公司股票", 8000, PropertyPurpose.General, none, {}, none, none, some FinancialAsset.Stock, none, true⟩
    (by simp [isPrivateProperty])

-- 示例8：班级集体财产（属于一种集体但不属于法条定义的劳动群众集体）
def classProperty : Property :=
  let classCollective : Collective := {
    baseType := CollectiveBaseType.Social,
    form := CollectiveForm.EducationalGroup,
    scale := CollectiveScale.Small,
    name := "高三一班",
    hasDefinedMembers := true,
    hasGovernance := true,
    hasCommonInterest := true,
    hasPropertyOwnership := true,
    formallyRecognized := true,
    legalStatusCode := none
  }
  {
    owner := OwnerType.Collective,
    assetName := "班费",
    value := 2000,
    purpose := PropertyPurpose.General,
    collective := some classCollective,
    isLegal := true
  }

-- 示例9：农村集体经济组织财产（符合法条定义的劳动群众集体）
def ruralCollectiveProperty : Property :=
  let ruralCollective : Collective := {
    baseType := CollectiveBaseType.Economic,
    form := CollectiveForm.RuralEconomic,
    scale := CollectiveScale.Medium,
    name := "某村民委员会",
    hasDefinedMembers := true,
    hasGovernance := true,
    hasCommonInterest := true,
    hasPropertyOwnership := true,
    formallyRecognized := true,
    legalStatusCode := none
  }
  {
    owner := OwnerType.Collective,
    assetName := "集体林地",
    value := 50000,
    purpose := PropertyPurpose.General,
    collective := some ruralCollective,
    isLegal := true
  }

example : isPublicProperty ruralCollectiveProperty := by simp [isPublicProperty, isLegalCollective, ruralCollectiveProperty]

package com.ohdogcat.model;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class PurchaseProduct {
    private Long member_fk;
    private Long purchase_fk;
    private Long option_fk;
    private Integer count;
}

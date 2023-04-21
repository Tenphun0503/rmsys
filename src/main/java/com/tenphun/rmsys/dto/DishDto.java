package com.tenphun.rmsys.dto;

import com.tenphun.rmsys.entity.Dish;
import com.tenphun.rmsys.entity.DishFlavor;
import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class DishDto extends Dish {
    private List<DishFlavor> flavors = new ArrayList<>();
    private String categoryName;
    private Integer copies;
}

package com.tenphun.rmsys.dto;

import com.tenphun.rmsys.entity.Dish;
import com.tenphun.rmsys.entity.Setmeal;
import com.tenphun.rmsys.entity.SetmealDish;
import lombok.Data;

import java.util.List;

@Data
public class SetmealDto extends Setmeal {
    private List<SetmealDish> setmealDishes;
    private String categoryName;
    private Long idType;
    private List<Dish> dishList;
}

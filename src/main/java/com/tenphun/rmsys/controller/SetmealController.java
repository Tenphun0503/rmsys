package com.tenphun.rmsys.controller;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.tenphun.rmsys.common.R;
import com.tenphun.rmsys.dto.SetmealDto;
import com.tenphun.rmsys.entity.Setmeal;
import com.tenphun.rmsys.service.SetmealService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping("setmeal")
public class SetmealController {
    @Autowired
    SetmealService setmealService;


    @PostMapping
    public R<String> add(@RequestBody SetmealDto setmealDto){
        setmealService.addWithDishes(setmealDto);
        return R.success("Add 1");
    }

    @GetMapping("/page")
    public R<Page<Setmeal>> page(int page, int pageSize, String name){
        Page<Setmeal> pageInfo = new Page<>(page, pageSize);

        LambdaQueryWrapper<Setmeal> wrapper = new LambdaQueryWrapper<>();
        wrapper.like(StringUtils.isNotEmpty(name), Setmeal::getName, name);
        wrapper.orderByDesc(Setmeal::getUpdateTime);

        setmealService.page(pageInfo, wrapper);
        return R.success(pageInfo);
    }



}

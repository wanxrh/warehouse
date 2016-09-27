<?php

/*
 * 支付模型
 */

class App_model extends CI_Model
{

    public function __construct()
    {
        parent::__construct();
    }

    /**
     * sku地图
     * @param $goods_id 商品ID
     * @param null $sku sku数组，默认需要查询
     * @return array
     * @author 王立
     */
    public function sku_map($goods_id, $sku = null)
    {
        if ($sku === null) {
            $sku = $this->db->where(array('goods_id' => $goods_id, 'stock <>' => 0))->get('goods_sku')->result_array();
        }
        $skuMap = [];
        foreach ($sku as $value) {
            $skuMap[] = array(
                'price' => $value['price'],
                'cost_price' => $value['cost_price'],
                'stock' => $value['stock'],
                'sku_id' => $value['sku_id'],
                'map' => explode(';', $value['properties'])
            );
        }
        return $skuMap;
    }

    /**
     * sku选项组合
     * @param $goods_id 商品ID
     * @param null $sku sku数组，默认需要查询
     * @return array
     * @author 王立
     */
    public function sku_part($goods_id, $sku = null)
    {
        if ($sku === null) {
            $sku = $this->db->where(array('goods_id' => $goods_id, 'stock <>' => 0))->get('goods_sku')->result_array();
        }
        //属性名
        $attr_name_arr = $this->db->where(array('goods_id' => $goods_id))->get('attr_name')->result_array();
        $attr_name_arr = array_column($attr_name_arr, 'attr_name', 'attr_name_id');
        //属性值
        $attr_value_arr = $this->db->where(array('goods_id' => $goods_id))->get('attr_value')->result_array();
        $attr_value_arr = array_column($attr_value_arr, 'attr_value', 'attr_value_id');
        //组装
        $goods_attr = $this->db->where_in('sku_id', array_column($sku, 'sku_id'))->get('goods_attr')->result_array();
        $skuPart = [];
        foreach ($attr_name_arr as $attr_name_id => $attr_name) {
            foreach ($goods_attr as $v) {
                if ($v['attr_name_id'] == $attr_name_id) {
                    $skuPart[$attr_name_id]['partName'] = $attr_name;
                    $skuPart[$attr_name_id]['partInfo'][$v['attr_name_id'] . ':' . $v['attr_value_id']] = array(
                        'key' => $v['attr_name_id'] . ':' . $v['attr_value_id'],
                        'name' => $attr_value_arr[$v['attr_value_id']]
                    );
                }
            }
            $skuPart[$attr_name_id]['partInfo'] = array_values($skuPart[$attr_name_id]['partInfo']);
        }
        return array_values($skuPart);
    }

    /**
     * 处理属性字符串
     * @param $sku_id skuid
     * @param $goods_id 商品ID
     * @param string $attr_separator 属性组分隔符，默认空格
     * @param string $separator 属性名称和值分隔符，默认:
     * @return string
     * @author 王立
     */
    public function spec_info($sku_id, $goods_id, $attr_separator = ' ', $separator = ':')
    {
        $attr_name = $this->db->where(array('goods_id' => $goods_id))->get('attr_name')->result_array();
        $attr_value = $this->db->where(array('goods_id' => $goods_id))->get('attr_value')->result_array();
        $attr_name = array_column($attr_name, 'attr_name', 'attr_name_id');
        $attr_value = array_column($attr_value, 'attr_value', 'attr_value_id');
        $str = '';
        $sku = $this->db->where(array('sku_id' => $sku_id))->get('goods_attr')->result_array();
        foreach ($sku as $v) {
            $str .= $attr_name[$v['attr_name_id']] . $separator . $attr_value[$v['attr_value_id']] . $attr_separator;
        }
        return trim($str, $attr_separator);
    }
}
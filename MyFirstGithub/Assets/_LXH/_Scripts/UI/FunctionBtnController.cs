using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

/// <summary>
/// 功能按钮控制器
/// </summary>
public class FunctionBtnController : MonoBehaviour
{
    /// <summary>
    /// 地图导航按钮
    /// </summary>
    Button Btn_MapPilot;
    /// <summary>
    /// 管道透明按钮
    /// </summary>
    Button Btn_TransparentPipe;
    /// <summary>
    /// 设备搜索按钮
    /// </summary>
    Button Btn_EquipmentSearch;
    /// <summary>
    /// 操作帮助按钮
    /// </summary>
    Button Btn_OperationToHelp;

    /// <summary>
    /// 地图导航面板
    /// </summary>
    GameObject MapPilot;

    /// <summary>
    /// 管道
    /// </summary>
    Transform PIP;

    // Use this for initialization
    void Start()
    {
        MapPilot = transform.parent.Find("MapBackGround").gameObject;
        PIP = GameObject.Find("PIP").transform;

        //找到对应的按钮
        Btn_MapPilot = transform.Find("Btn_MapPilot").GetComponent<Button>();
        Btn_TransparentPipe = transform.Find("Btn_TransparentPipe").GetComponent<Button>();
        Btn_EquipmentSearch = transform.Find("Btn_EquipmentSearch").GetComponent<Button>();
        Btn_OperationToHelp = transform.Find("Btn_OperationToHelp").GetComponent<Button>();

        //为按钮添加点击事件
        Btn_MapPilot.onClick.AddListener(OnBtn_MapPilotClick);
        Btn_TransparentPipe.onClick.AddListener(OnBtn_TransparentPipeClick);
        Btn_EquipmentSearch.onClick.AddListener(OnBtn_EquipmentSearchClick);
        Btn_OperationToHelp.onClick.AddListener(OnBtn_OperationToHelpClick);
    }

    /// <summary>
    /// 点击地图导航按钮
    /// </summary>
    private void OnBtn_MapPilotClick()
    {
        MapPilot.SetActive(true);
    }

    /// <summary>
    /// 点击管道透明按钮
    /// </summary>
    private void OnBtn_TransparentPipeClick()
    {
        Debug.Log("点击管道透明按钮");
        PIP.Find("OutletPipe").gameObject.SetActive(false);
    }

    /// <summary>
    /// 点击设备搜索按钮
    /// </summary>
    private void OnBtn_EquipmentSearchClick()
    {
        Debug.Log("点击设备搜索按钮");
    }

    /// <summary>
    /// 点击操作帮助按钮
    /// </summary>
    private void OnBtn_OperationToHelpClick()
    {
        Debug.Log("点击操作帮助按钮");
    }
    
}

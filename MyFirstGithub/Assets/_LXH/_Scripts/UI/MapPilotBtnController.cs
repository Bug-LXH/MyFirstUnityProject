using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

/// <summary>
/// 地图按钮控制器
/// </summary>
public class MapPilotBtnController : MonoBehaviour
{
    /// <summary>
    /// 地图导航关闭按钮
    /// </summary>
    Button Btn_Close;

    /// <summary>
    /// 地图导航楼层按钮数组
    /// </summary>
    Button[] Btn_FloorArr;

    /// <summary>
    /// 当前选择的楼层按钮（默认选择1层）
    /// </summary>
    Button CurrentSelectBtn;

    /// <summary>
    /// 地图
    /// </summary>
    public GameObject[] FloorArr;

    /// <summary>
    /// 当前显示楼层
    /// </summary>
    GameObject CurrentShowFloor;

    public static MapPilotBtnController Instance;

    private void Awake()
    {
        Instance = this;
    }

    // Use this for initialization
    void Start()
    {
        Btn_Close = transform.Find("Bg_Btn_Close").GetChild(0).GetComponent<Button>();
        Btn_FloorArr = transform.Find("Btn_Floor").GetComponentsInChildren<Button>();

        Btn_Close.onClick.AddListener(OnBtn_CloseClicked);

        foreach (Button button in Btn_FloorArr)
        {
            button.onClick.AddListener(() => OnBtn_FloorClicked(button));
        }
        //默认当前显示楼层为1层
        CurrentShowFloor = FloorArr[0];
        CurrentSelectBtn = Btn_FloorArr[0];
        CurrentSelectBtn.GetComponent<Image>().color = new Color(0, 255, 255, 255);
    }

    /// <summary>
    /// 点击楼层按钮时
    /// </summary>
    private void OnBtn_FloorClicked(Button btn)
    {
        //之前选择的楼层恢复未选中状态
        CurrentSelectBtn.GetComponent<Image>().color = Color.white;
        //当前点击楼层赋值
        CurrentSelectBtn = btn;
        //选择的楼层改为选中状态
        CurrentSelectBtn.GetComponent<Image>().color = new Color(0,255, 255, 255);
        //隐藏之前显示楼层的地图
        CurrentShowFloor.SetActive(false);
        //遍历所有楼层，找到点击的楼层对应的地图显示出来
        for (int i = 0; i < FloorArr.Length; i++)
        {
            if (FloorArr[i].name.Equals(btn.name))
            {
                CurrentShowFloor = FloorArr[i];
                CurrentShowFloor.SetActive(true);
                break;
            }
        }
    }

    /// <summary>
    /// 点击关闭按钮
    /// </summary>
    private void OnBtn_CloseClicked()
    {
        transform.parent.gameObject.SetActive(false);
    }

    // Update is called once per frame
    void Update()
    {

    }
}

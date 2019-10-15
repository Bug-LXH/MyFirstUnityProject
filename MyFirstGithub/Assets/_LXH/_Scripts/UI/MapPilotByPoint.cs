using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

/// <summary>
/// 通过地图中的点进行地图导航
/// </summary>
public class MapPilotByPoint : MonoBehaviour
{
    /// <summary>
    /// 地图上的点
    /// </summary>
    Button Point;

    /// <summary>
    /// 每一个楼层的点
    /// </summary>
    GameObject PosObjGroup;

    /// <summary>
    /// 相机
    /// </summary>
    GameObject CameraController;

    // Use this for initialization
    void Start()
    {
        PosObjGroup = GameObject.Find("PosObjGroup");
        CameraController = GameObject.Find("CameraController");
        Point = transform.GetComponent<Button>();
        Point.onClick.AddListener(OnPointClicked);
    }

    /// <summary>
    /// 点击地图上的点
    /// </summary>
    private void OnPointClicked()
    {
        string parentName = transform.parent.name;
        if (parentName.EndsWith("1"))
        {
            SetPos(1);
        }
        else if (parentName.EndsWith("2"))
        {
            SetPos(2);
        }
        else if (parentName.EndsWith("3"))
        {
            SetPos(3);
        }
        else if (parentName.EndsWith("4"))
        {
            SetPos(4);
        }
        else if (parentName.EndsWith("5"))
        {
            SetPos(5);
        }
        else if (parentName.EndsWith("6"))
        {
            SetPos(6);
        }
        else if (parentName.EndsWith("7"))
        {
            SetPos(7);
        }
    }

    /// <summary>
    /// 移动相机到对应楼层相应的点
    /// </summary>
    /// <param name="n"></param>
    void SetPos(int n)
    {
        CameraController.transform.position = PosObjGroup.transform.Find(n+"F_" + Point.name).position;
        //隐藏地图
        transform.parent.parent.parent.gameObject.SetActive(false);
    }
}

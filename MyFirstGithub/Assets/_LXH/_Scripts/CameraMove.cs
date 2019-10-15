using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraMove : MonoBehaviour
{
    Vector3 offsetPosition;
    float distance;
    float scrollSpeed = 10f;
    float rotateSpeed = 2f;
    bool isRotating = false;
    GameObject game;

    // Use this for initialization
    void Start()
    {
        offsetPosition = transform.position;
    }

    private void FixedUpdate()
    {
        if (Input.GetKey(KeyCode.W))
        {
            transform.Translate(Vector3.forward * Time.deltaTime);
        }

        if (Input.GetKey(KeyCode.S))
        {
            transform.Translate(Vector3.back * Time.deltaTime);
        }

        if (Input.GetKey(KeyCode.A))
        {
            transform.Rotate(0,-50f * Time.deltaTime,0);
        }

        if (Input.GetKey(KeyCode.D))
        {
            transform.Rotate(0,50f * Time.deltaTime,0);
        }
        //transform.position = offsetPosition;
        //ScrollView();
        //RotateView();
    }
    #region 拉近拉远，旋转
    //void ScrollView()
    //{
    //    distance = offsetPosition.magnitude;
    //    distance -= Input.GetAxis("Mouse ScrollWheel") * scrollSpeed;
    //    distance = Mathf.Clamp(distance, 5, 18);
    //    offsetPosition = offsetPosition.normalized * distance;
    //}

    //void RotateView()
    //{
    //    if (Input.GetMouseButtonDown(1))
    //    {
    //        isRotating = true;
    //    }
    //    if (Input.GetMouseButtonUp(1))
    //    {
    //        isRotating = false;
    //    }

    //    if (isRotating)
    //    {
    //        transform.RotateAround(transform.position, transform.up, rotateSpeed * Input.GetAxis("Mouse X"));//简单的说，在世界坐标的某位置的某轴按照旋转度数旋转调用这个函数的物体。
    //        Vector3 originalPos = transform.position; Quaternion originalRotation = transform.rotation;
    //        transform.RotateAround(transform.position, transform.right, -rotateSpeed * Input.GetAxis("Mouse Y"));//影响本物体transform的属性有两个，一个是position 一个是rotation
    //        float x = transform.eulerAngles.x;
    //        if (x < 10 || x > 80)//垂直方向角度限制:不论怎么旋转都限制在10到80度之间
    //        {
    //            transform.position = originalPos;
    //            transform.rotation = originalRotation;
    //        }
    //        x = Mathf.Clamp(x, 10, 80);//限制x的值在10和80之间， 如果x小于10，返回10。 如果x大于80，返回80，否则返回value 
    //        transform.eulerAngles = new Vector3(x, transform.eulerAngles.y, transform.eulerAngles.z);
    //    }
    //}
    #endregion

}

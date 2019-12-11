using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class scrollingTexture : MonoBehaviour
{
    public float scrollX = 0.0f;
    public float scrollY = -0.01f;

    void Update()
    {
        float offsetX = Time.time * scrollX;
        float offsetY = Time.time * scrollY;
        GetComponent<Renderer>().material.mainTextureOffset = new Vector2(offsetX, offsetY);
    }

    // public Material _material;
    // public float currentScroll = 0;
    // public float speed = 0.5f;

    // void Start()
    // {
    //     _material = GetComponent<SpriteRenderer>().material;
    // }

    // void Update()
    // {
    //     currentScroll += speed * Time.deltaTime;
    //     _material.mainTextureOffset = new Vector2(currentScroll, 0);
    // }
}

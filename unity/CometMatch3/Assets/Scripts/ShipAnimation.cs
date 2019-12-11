using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShipAnimation : MonoBehaviour
{

    public float speed = 1.0f;
    public bool up = true;

    void Update() {
        if (gameObject.transform.position.y < -5)
        {
            speed = 0.0835f;
            transform.Translate(Vector3.up * speed * Time.deltaTime, Space.World);
        }
        if (gameObject.transform.position.y >= -5 && gameObject.transform.position.y < 6)
        {
            speed = 5.0f;
            transform.Translate(Vector3.up * speed * Time.deltaTime, Space.World);
        }
        if (gameObject.transform.position.y > 6 && gameObject.transform.position.y < 7 )
        {
            speed = 0.1f;
            if (up)
                transform.Translate(Vector3.up * speed * Time.deltaTime, Space.World);
            else
                transform.Translate(Vector3.down * speed * Time.deltaTime, Space.World);
        }
        if (gameObject.transform.position.y > 5.9 && gameObject.transform.position.y < 6.1)
            up = true;
        if (gameObject.transform.position.y > 6.9 && gameObject.transform.position.y < 7.1)
            up = false;
    }
}





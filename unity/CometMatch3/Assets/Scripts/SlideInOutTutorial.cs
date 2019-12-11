using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SlideInOutTutorial : MonoBehaviour
{

    public float speed = 3.0f;

    void Update() {
        if (gameObject.transform.position.x < 2.2)
            transform.Translate(Vector3.right * speed * Time.deltaTime, Space.World);
        if (gameObject.transform.position.x >= 2.1 && gameObject.transform.position.x <= 2.4)
        {
            speed = 0.03f;
            transform.Translate(Vector3.right * speed * Time.deltaTime, Space.World);
        }
        if (gameObject.transform.position.x > 2.4 && gameObject.transform.position.x <= 9 )
        {
            speed = 3.0f;
            transform.Translate(Vector3.right * speed * Time.deltaTime, Space.World);
        }
        if (gameObject.transform.position.x > 9)
        {
            speed = 0.0f;
            gameObject.SetActive(false);
        }
    }
}





using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TestMove : MonoBehaviour
{

    public float MOVE_SPD = 10.0f;

    void Update() {
        if (gameObject.transform.position.x > -10)
            transform.Translate(Vector3.left * MOVE_SPD * Time.deltaTime, Space.World);
            transform.Translate(Vector3.down * MOVE_SPD * Time.deltaTime, Space.World);
        if (gameObject.transform.position.x <= -10)
        {
            MOVE_SPD = 0.15f;
            transform.Translate(Vector3.right * 20, Space.World);
            transform.Translate(Vector3.up * 20, Space.World);
        }
        if (gameObject.transform.position.x <= 9 && gameObject.transform.position.x >= 8 )
        {
            MOVE_SPD = 7.5f;
        }
    }
}





using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// Making child not rotate with parent

public class ClampRotation : MonoBehaviour
{
    void Update()
    {
        transform.rotation = Quaternion.identity;
    }
}

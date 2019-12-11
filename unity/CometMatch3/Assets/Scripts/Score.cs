// To use:
//GameObject skillObject = GameObject.Find("Skill_Sword");
//Skill skill = skillObject.GetComponent<Skill>();
//skill.IncreaseCount(1); 

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Score : MonoBehaviour
{
    public Text txt; // assign it from inspector
    
    [SerializeField]
    public int score = 0;

    void Start()
    {
        txt.text = score.ToString();
    }

    public int GetScore()
    {
        return score;
    }

    public void IncreaseCount(int amt) {
        score += amt;
        txt.text = score.ToString();
    }

    public void DecreaseCount(int amt)
    {
        score -= amt;
        txt.text = score.ToString();
    }
}


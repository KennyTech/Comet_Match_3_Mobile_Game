using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;


public class GameStateManager : MonoBehaviour
{

    [SerializeField]
    public int level;

    [SerializeField]
    public static Text levelText;

    public static GameStateManager instance;

    // Start is called before the first frame update
    void Awake()
    {
        if (instance == null)
        {
            instance = this;
        }
        else if (instance != this)
        {
            // A unique case where the Singleton exists but not in this scene
            if (instance.gameObject.scene.name == null)
            {
                instance = this;
            }
            else
            {
                Destroy(this);
            }
        }

    }

    public void setGameLevel(int level)
    {
        if (level == 1)
            levelText.text = "Mission: Japan";
        else if (level == 2)
            levelText.text = "Mission: USA";
        else if (level == 3)
            levelText.text = "Mission: Russia";
        else if (level == 4)
            levelText.text = "Mission: France";
        else if (level == 5)
            levelText.text = "Mission: China";
    }

    // Update is called once per frame
    //void Update()
    //{
    //    
    //}

    public void AttackEnemy()
    {
        // if (attackSkill.GetValue() <= 0) return;
        // attackSkill.DecreaseCount();
        // currentEnemy.TakeDamage(50, Enemy.DamageType.Normal);
    }

    public void IncreaseDistance()
    {
        // if (distanceSkill.GetValue() <= 0) return;
        // distanceSkill.DecreaseCount();
        // currentEnemy.IncreaseDistance(10);
    }

    // /// <summary>
    // /// Temporary
    // /// </summary>
    // /// <returns></returns>
    // public Enemy GetEnemy()
    // {
    //     print("No enemy");
    //     return;
    // }
}

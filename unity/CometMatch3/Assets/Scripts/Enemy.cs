using System.Collections;
using System.Collections.Generic;
using UnityEngine;

/*
* To-Do: Add battle system to Match 3 (EXTRA FEATURE TIME PERMITTING)
*/

public class Enemy : MonoBehaviour
{
    // Enemy battle state
    public enum State
    {
        Walking,
        Flying,
        Retreating,
        Attacking,
        Idling
    }

    // ?? Experimental ??
    public enum Status
    {
        Normal,
        Paralyzed
    }

    // ?? Experimental ??
    public enum DamageType
    {
        Normal,
        Incendiary,
        Metal,
        Nuclear,
        Ballistic,
        Physical
    }

    [SerializeField]
    State currentState;

    [Header("Stats")]
    [SerializeField]
    float maxHealth = 1;
    [SerializeField]
    float health         = 360;          // Health
    [SerializeField]
    float attack        = 15;           // Attack

    [SerializeField]
    float moveSpeed = 10.0f;       // Movement Speed of enemy

    /// <summary>
    /// Rename these to "distance"
    /// </summary>
    [SerializeField]
    float maxDistance = 15f;
    [SerializeField]
    float currentDistance = 15f;

    Animator anim;
    Rigidbody2D rb;

    [SerializeField]
    UnityEngine.UI.Image healthImage;
    //[SerializeField]
    //TMPro.TextMeshProUGUI distanceText;

    public GameObject enemy;

    private static bool isAttacking = false;
    private static bool isColliding = false;

    bool attackedOnce = false;

    void Awake()
    {
        rb = GetComponent<Rigidbody2D>();
        anim = enemy.GetComponent<Animator>();
        currentState = State.Walking;
        health = maxHealth;
    }

    // TO-DO: Fill enemy action gauge over time then make enemy do attack action 
    void Update()
    {
        if (currentDistance > 0)
        {
            currentDistance -= Time.deltaTime;
            UpdateDistanceText();
        }
        else if (!attackedOnce)
        {
            anim.SetTrigger("attack");
            attackedOnce = true;
        }
    }

    public void IncreaseDistance(float amount)
    {
        currentDistance += amount;
        UpdateDistanceText();
    }

    public void ResetDistance()
    {
        currentDistance = maxDistance;
        UpdateDistanceText();
        attackedOnce = false;
    }

    public void UpdateDistanceText()
    {
        //distanceText.text = currentDistance.ToString();
    }

    //private void OnEnable()
    //{
    //    
    //}

    // TO-DO, damage amount and type
    public void TakeDamage(float amount, DamageType type)
    {
        health -= amount;
        healthImage.fillAmount = health / maxHealth;
        if (health <= 0)
        {
            KillEnemy();
        }
    }

    public void KillEnemy()
    {
        gameObject.SetActive(false);
    }

    // not working
    void OnCollisionEnter2D(Collision2D col)
    {
        Debug.Log("Collision");
        if (!isAttacking)
            isAttacking = true;
        isColliding = true;
        currentState = State.Attacking;
    }

    // not working
    void OnCollisionExit2D(Collision2D col)
    {
        Debug.Log("Collision Exit");
        isColliding = false;
    }

}





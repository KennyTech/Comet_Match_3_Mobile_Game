using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Fuel : MonoBehaviour
{
    //public Text txt; // assign it from inspector

    [SerializeField]
    UnityEngine.UI.Image fuelBar;
    
    [SerializeField]
    int amount = 2000;

    void Start()
    {

    }

    void Update() 
    {
        DecreaseFuel(1);
        fuelBar.fillAmount = amount / 1500.0f;

        // Out of fuel, end of match, send message to Flutter to close Unity and go to Flutter's game over screen
        if (amount <= 0)
        {
            // Fetch player score
            int gameOverScore = 0;
            GameObject scoreObject = GameObject.Find("Score_Text");
            Score score = scoreObject.GetComponent<Score>();
            gameOverScore = score.GetScore();

            // Convert score to string for sending
            string scoreString = gameOverScore.ToString();

            // This method is used to send data from Unity to Flutter (send score to Flutter)
            UnityMessageManager.Instance.SendMessageToFlutter(scoreString);

            // Destroy
            Destroy(this.gameObject);
        }
    }

    public int GetValue()
    {
        return amount;
    }

    public void IncreaseFuel(int amt) {
        amount += amt;
        if (amount > 1500)
            amount = 1500; // Max 1500 fuel
    }

    public void DecreaseFuel(int amt)
    {
        amount -= amt;
    }
}


using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;


public class ButtonFunctions : MonoBehaviour
{

    [SerializeField]
    GameObject GameOverScreen;
    public void RestartGame() {
        SceneManager.LoadSceneAsync(SceneManager.GetActiveScene().buildIndex);
        GameOverScreen.SetActive(false);
    }

    public void QuitGame() {
        Application.Quit();
        GameOverScreen.SetActive(false);
    }
}
    


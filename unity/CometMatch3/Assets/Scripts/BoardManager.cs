using UnityEngine;
using System.Collections;

namespace CometMatchThree {

    public class BoardManager : MonoBehaviour {

        /* =============================================================================================================
         *  TODO: Define orb types
         * =============================================================================================================
         */
        public enum orbType
        {
            orb_Saturn,         // Matching this type grants +300 score
            orb_SuperComet,     // Matching this type grants +200 score
            orb_Ship,           // Matching this type grants +5% fuel
            orb_Comet,          // Matching this type grants +100 score
            orb_UFO             // Matching this type grants +10% fuel
        }

        /* =============================================================================================================
         *  Orb struct
         * =============================================================================================================
         */
        private struct Orb 
        {
            public GameObject   orbObject;      // The orb gameObject for transforming, setting color/icon, destroying
            public OrbHandler   orbManager;     // the orb handler (orbHandler.cs) which drops the orbs down
            public int          color;          // The orb color, modifiable in inspector
            public int          dropDist;       // the 'y' distance that the orbs will drop down from its spawn point
            public int          matchNumber;    // match count
        }

        /* =============================================================================================================
         *  Board manager variables
         * =============================================================================================================
         */
        [Header("The orb sphere color (material)")]
        [SerializeField] private Material orbSaturn;
        [SerializeField] private Material orbSuperComet;
        [SerializeField] private Material orbShip;
        [SerializeField] private Material orbComet;
        [SerializeField] private Material orbUFO;

        [Header("The orb icon type (sprite)")]
        [SerializeField] private Sprite iconSaturn;
        [SerializeField] private Sprite iconSuperComet;
        [SerializeField] private Sprite iconShip;
        [SerializeField] private Sprite iconComet;
        [SerializeField] private Sprite iconUFO;

        // Board size
        private static int boardSizeX = 6;
        private static int boardSizeY = 5;
        
        // The full orb board array
        private Orb[,] orbArr = new Orb[boardSizeX, boardSizeY];

        // A semi-transparent orb visual effect for when the player drags the orb
        private Orb orbClone = new Orb();

        // Player mouse position
        private Vector2 mousePos = Vector2.zero;

        // Position tracker for the held orb
        private int heldOrbX = 0, heldOrbY = 0;

        // Board locks during matching/skyfall time
        private bool boardIsLocked = false;

        // Track player mouse down/release for dragging orbs
        private bool mouseDown = false;

        // Dynamic pitch of combo sound effect (pitch increased per combo)
        private float pitch = 0.8f;

        // Actual combo count
        private int comboCount = 0;

        /* =============================================================================================================
         *  Initialization of the board on startup
         * =============================================================================================================
         */
        private void Start () {
            InitBoard();
        }

        private void InitBoard () {
            for (int y = 0; y < boardSizeY; y++) {
                for (int x = 0; x < boardSizeX; x++) {
                    SpawnOrb(x, y, 10);
                }
            }

            SkyfallOrbs();
        }

        /* =============================================================================================================
         *  Periodic update to check player click, drag, and release of orb
         * =============================================================================================================
         */
        private void Update () {
            if (boardIsLocked) return;
            
            // First Click Down
            if (Input.GetMouseButtonDown(0)) {
                mousePos = Camera.main.ScreenToWorldPoint(Input.mousePosition);
                mouseDown = true;
                pitch = 0.8f;   // Reset pitch
                comboCount = 0; // Reset combo count
                Debug.Log("mouseY: " + mousePos.y);
                //if (mousePos.y < 4.8)   // > 4.8 is top half of screen, don't activate orbs when clicking UI
                CheckOrbClick();
            // Hold Down - do swaps
            } else if (Input.GetMouseButton(0) && mouseDown) {
                mousePos = Camera.main.ScreenToWorldPoint(Input.mousePosition);
                    CheckOrbSwap();
            }
            // Release - check matches
            if (Input.GetMouseButtonUp(0) && mouseDown) {
                mousePos = Camera.main.ScreenToWorldPoint(Input.mousePosition);
                DropOrb();
                boardIsLocked = true;
                StartCoroutine(MatchOrbs());
                mouseDown = false;
            }
        }

        /* =============================================================================================================
         *  Orb spawning
         * =============================================================================================================
         */
        private void SpawnOrb (int x, int y, int drop) {
            GameObject orb = (GameObject)Instantiate(Resources.Load("Orb"), new Vector2(x, y+10), Quaternion.identity);

            if (orbArr[x, y].orbObject != null)
                Destroy(orbArr[x, y].orbObject);

            orbArr[x, y] = new Orb 
            {
                orbObject = orb,
                dropDist = drop,
                orbManager = orb.GetComponent<OrbHandler>(),
                matchNumber = 0
            };

            SetRandomColorAndIcon(x, y);
        }

        /* =============================================================================================================
         *  Orb set random color and icon function
         * =============================================================================================================
         */
        private void SetRandomColorAndIcon (int x, int y) {
            int randomColor = Random.Range(0, 5);

            switch (randomColor) {
                case 0: // Saturn
                    orbArr[x, y].orbObject.transform.GetChild(0).GetComponent<MeshRenderer>().material = orbSaturn;
                    orbArr[x, y].orbObject.transform.GetChild(1).GetComponent<SpriteRenderer>().sprite = iconSaturn;
                    break;
                case 1: // Supercomet
                    orbArr[x, y].orbObject.transform.GetChild(0).GetComponent<MeshRenderer>().material = orbSuperComet;
                    orbArr[x, y].orbObject.transform.GetChild(1).GetComponent<SpriteRenderer>().sprite = iconSuperComet;
                    break;
                case 2: // Ship
                    orbArr[x, y].orbObject.transform.GetChild(0).GetComponent<MeshRenderer>().material = orbShip;
                    orbArr[x, y].orbObject.transform.GetChild(1).GetComponent<SpriteRenderer>().sprite = iconShip;
                    break;
                case 3: // Comet
                    orbArr[x, y].orbObject.transform.GetChild(0).GetComponent<MeshRenderer>().material = orbComet;
                    orbArr[x, y].orbObject.transform.GetChild(1).GetComponent<SpriteRenderer>().sprite = iconComet;
                    break;
                case 4: // UFO
                    orbArr[x, y].orbObject.transform.GetChild(0).GetComponent<MeshRenderer>().material = orbUFO;
                    orbArr[x, y].orbObject.transform.GetChild(1).GetComponent<SpriteRenderer>().sprite = iconUFO;
                    break;
            }
            orbArr[x, y].color = randomColor;
        }

        // TO-DO
        private void SetOrbType (orbType type) {

        }

        /* =============================================================================================================
         *  Skyfall - drop orbs 
         * =============================================================================================================
         */
        private void SkyfallOrbs () {
            for (int y = 0; y < boardSizeY; y++) {
                for (int x = 0; x < boardSizeX; x++) {
                    if (orbArr[x, y].dropDist > 0) {
                        orbArr[x, y].orbManager.InitDrop(orbArr[x, y].dropDist);
                        orbArr[x, y].dropDist = 0;
                    }
                }
            }
        }

        /* =============================================================================================================
         *  Check for orb click and create semi-transparent visual effect on initially clicked orb
         * =============================================================================================================
         */
        private void CheckOrbClick () {
            int clickX = Mathf.RoundToInt(mousePos.x);
            int clickY = Mathf.RoundToInt(mousePos.y);

            // TO-DO: Make so user can't click above (currently assumes nearest orb when user taps out of board)
            if (clickX > 5) clickX = 5;
            if (clickY > 4) clickY = 4;
            if (clickX < 0) clickX = 0;
            if (clickY < 0) clickY = 0;

            orbArr[clickX, clickY].orbManager.mouseOrb = true;
            heldOrbX = clickX;
            heldOrbY = clickY;

            // Make transparent clone underneath dragged orb when dragging orbs (visual effect)
            CreateNewOrbClone(clickX, clickY);
            Material orbMat = orbArr[clickX, clickY].orbObject.transform.GetChild(0).GetComponent<MeshRenderer>().material;
            Sprite orbSprite = orbArr[clickX, clickY].orbObject.transform.GetChild(1).GetComponent<SpriteRenderer>().sprite;
            Color32 orbCol = orbMat.color;
            orbCol.a = 65;
            
            // Sprite transparent when dragging
            Color32 spriteAlpha = orbArr[clickX, clickY].orbObject.transform.GetChild(1).GetComponent<SpriteRenderer>().color;
            spriteAlpha.a = 65;

            // Apply
            orbClone.orbObject.transform.GetChild(0).GetComponent<MeshRenderer>().material = orbMat;
            orbClone.orbObject.transform.GetChild(0).GetComponent<MeshRenderer>().material.color = orbCol;
            orbClone.orbObject.transform.GetChild(1).GetComponent<SpriteRenderer>().sprite = orbSprite;
            orbClone.orbObject.transform.GetChild(1).GetComponent<SpriteRenderer>().color = spriteAlpha;
        }

        /* =============================================================================================================
         *  Whenever orb is being dragged, this checks for swap, calling coroutine to visually lerp rotate orb for swap
         * =============================================================================================================
         */
        private void CheckOrbSwap () {
            int mouseX = Mathf.RoundToInt(mousePos.x);
            int mouseY = Mathf.RoundToInt(mousePos.y);

            // TO-DO: Make so user can't click above (currently assumes nearest orb when click when user clicks monster/player)
            if (mouseX > 5) mouseX = 5;
            if (mouseY > 4) mouseY = 4;
            if (mouseX < 0) mouseX = 0;
            if (mouseY < 0) mouseY = 0;

            //if (mouseX != heldOrbX || mouseY != heldOrbY) 
            if (Mathf.Abs(mousePos.x - heldOrbX) > 0.65f || Mathf.Abs(mousePos.y - heldOrbY) > 0.65f) 
            {
                if (mouseX - heldOrbX > 1)
                    mouseX = heldOrbX + 1;
                if (heldOrbX - mouseX > 1)
                    mouseX = heldOrbX - 1;
                if (mouseY - heldOrbY > 1)
                    mouseY = heldOrbY + 1;
                if (heldOrbY - mouseY > 1)
                    mouseY = heldOrbY - 1;

                StartCoroutine(SwapOrbs(mouseX, mouseY));
            }
        }

        /* =============================================================================================================
         *  Do the orb swap with lerp and play the orb swapping sound effect
         * =============================================================================================================
         */
        private IEnumerator SwapOrbs (int newOrbX, int newOrbY) {
            Vector3 targetAngle;
            GameObject orbSwapper = new GameObject();
            WaitForSeconds swapLoopTimer = new WaitForSeconds(0.01f);

            // TO-DO: USE AUDIO MANAGER
            AudioSource audio = GetComponent<AudioSource>();
            audio.Play(0);

            float swapLerpPercent = 0f;
            int oldOrbX = heldOrbX, oldOrbY = heldOrbY;

            heldOrbX = newOrbX; heldOrbY = newOrbY;

            Orb tempOrb = orbArr[newOrbX, newOrbY];
            orbArr[newOrbX, newOrbY] = orbArr[oldOrbX, oldOrbY];
            orbArr[oldOrbX, oldOrbY] = tempOrb;

            if (orbClone.orbObject.transform.parent != null) {
                orbClone.orbObject.transform.parent = null;
                orbClone.orbObject.transform.position = new Vector2(oldOrbX, oldOrbY);
            }

            if (orbArr[oldOrbX, oldOrbY].orbObject.transform.parent != null) {
                orbArr[oldOrbX, oldOrbY].orbObject.transform.parent = null;
                orbArr[oldOrbX, oldOrbY].orbObject.transform.position = new Vector2(newOrbX, newOrbY);
            }

            targetAngle = new Vector3(0, 0, 180f);
            orbSwapper.transform.position = new Vector2(oldOrbX - ((oldOrbX - newOrbX) / 2f), oldOrbY - ((oldOrbY - newOrbY) / 2f));

            orbClone.orbObject.transform.parent = orbArr[oldOrbX, oldOrbY].orbObject.transform.parent = orbSwapper.transform;

            while (swapLerpPercent <= 1f) {
                orbSwapper.transform.eulerAngles = Vector3.Lerp(Vector3.zero, targetAngle, swapLerpPercent);
                swapLerpPercent += 0.1f;
                yield return swapLoopTimer;
            }

            orbSwapper.transform.eulerAngles = targetAngle;

            if (orbArr[oldOrbX, oldOrbY].orbObject.transform.parent == orbSwapper.transform)
                orbArr[oldOrbX, oldOrbY].orbObject.transform.parent = null;
            if (orbClone.orbObject != null)
                if (orbClone.orbObject.transform.parent == orbSwapper.transform)
                    orbClone.orbObject.transform.parent = null;

            if(orbSwapper != null)
                Destroy(orbSwapper);
        }

        /* =============================================================================================================
         *  Releasing the grabbed orb, placing it down, destroying the semi-transparent visual clone
         * =============================================================================================================
         */
        private void DropOrb () {
            orbArr[heldOrbX, heldOrbY].orbManager.mouseOrb = false;
            if (orbArr[heldOrbX, heldOrbY].orbObject != null) {
                orbArr[heldOrbX, heldOrbY].orbObject.transform.position = new Vector2(heldOrbX, heldOrbY);
            }
            else
            {
                print("orb is gone, why?");
            }
            if (orbClone.orbObject != null)
                Destroy(orbClone.orbObject);
        }

        /* =============================================================================================================
         *  Create a new orb clone for semi-transparent visual orb effect
         * =============================================================================================================
         */
        private void CreateNewOrbClone (int cloneX, int cloneY) {
            GameObject orb = (GameObject)Instantiate(Resources.Load("Orb"), new Vector2(cloneX, cloneY), Quaternion.identity);
            orbClone = new Orb {
                color = orbArr[cloneX, cloneY].color,
                orbObject = orb,
                orbManager = orb.GetComponent<OrbHandler>()
            };
        }

        /* =============================================================================================================
         *  Match 3 algorithm, check for matches. Currently a disgustingly inefficient approach.
         * =============================================================================================================
         */
        private IEnumerator MatchOrbs () {
            bool matchMade = false;
            int matchCount = 0, oldMatchCount = 0;

            // Slight beginning delay
            yield return new WaitForSeconds(0.5f);
            
            for (int y = 0; y < boardSizeY; y++) {
                for (int x = 0; x < boardSizeX; x++) {
                    int currentColor = orbArr[x, y].color;
                    int oldMatchFound = 0;

                    // Checking for matches to the right
                    if (x < 4) {
                        int z = 1;
                        
                        while (x + z < boardSizeX) {
                            if (orbArr[x + z, y].color == currentColor) {
                                if (orbArr[x + z, y].matchNumber > 0 && (oldMatchFound > orbArr[x + z, y].matchNumber || oldMatchFound == 0))
                                    oldMatchFound = orbArr[x + z, y].matchNumber;
                                z++;
                            } else break;
                        }

                        if (z > 2) {
                            matchMade = true;
                            Debug.Log("Match Length: " + z);
                            if (matchCount == oldMatchCount) matchCount++;
                            for (int i = 0; i < z; i++) {
                                if (oldMatchFound > 0)
                                    orbArr[x + i, y].matchNumber = oldMatchFound;
                                else orbArr[x + i, y].matchNumber = matchCount;
                            }
                        }
                    }

                    // Checking for matches to the left
                    if (x > 1) {
                        int z = 1;

                        while (x - z > -1) {
                            if (orbArr[x - z, y].color == currentColor) {
                                if (orbArr[x - z, y].matchNumber > 0 && (oldMatchFound > orbArr[x - z, y].matchNumber || oldMatchFound == 0))
                                    oldMatchFound = orbArr[x - z, y].matchNumber;
                                z++;
                            } else break;
                        }

                        if (z > 2) {
                            matchMade = true;
                            Debug.Log("Match Length: " + z);
                            if (matchCount == oldMatchCount) matchCount++;
                            for (int i = 0; i < z; i++) {
                                if (oldMatchFound > 0)
                                    orbArr[x - i, y].matchNumber = oldMatchFound;
                                else orbArr[x - i, y].matchNumber = matchCount;
                            }
                        }
                    }

                    // Checking for matches up above
                    if (y < 3) {
                        int z = 1;

                        while (y + z < 5) {
                            if (orbArr[x, y + z].color == currentColor) {
                                if (orbArr[x, y + z].matchNumber > 0 && (oldMatchFound > orbArr[x, y + z].matchNumber || oldMatchFound == 0))
                                    oldMatchFound = orbArr[x, y + z].matchNumber;
                                z++;
                            } else break;
                        }

                        if (z > 2) {
                            matchMade = true;
                            Debug.Log("Match Length: " + z);
                            if (matchCount == oldMatchCount) matchCount++;
                            for (int i = 0; i < z; i++) {
                                if (oldMatchFound > 0)
                                    orbArr[x, y + i].matchNumber = oldMatchFound;
                                else orbArr[x, y + i].matchNumber = matchCount;
                            }
                        }
                    }

                    // Checking for matches down below
                    if (y > 1) {
                        int z = 1;

                        while (y - z > -1) {
                            if (orbArr[x, y - z].color == currentColor) {
                                if (orbArr[x, y - z].matchNumber > 0 && (oldMatchFound > orbArr[x, y - z].matchNumber || oldMatchFound == 0))
                                    oldMatchFound = orbArr[x, y - z].matchNumber;
                                z++;
                            } else break;
                        }

                        if (z > 2) {
                            matchMade = true;
                            Debug.Log("Match Length: " + z);
                            if (matchCount == oldMatchCount) matchCount++;
                            for (int i = 0; i < z; i++) {
                                if (oldMatchFound > 0)
                                    orbArr[x, y - i].matchNumber = oldMatchFound;
                                else orbArr[x, y - i].matchNumber = matchCount;
                            }
                        }
                    }

                    oldMatchCount = matchCount;
                }
            }

            // Horrid implementation of removing matched objects and counting combos
            if (matchMade) {

                Debug.Log("MatchCount: " + matchCount);
                int counter = 0;            // Counting combos
                int prevCounter = 0;        // Detecting combo type
                int mostRecentColor = 0;    // Detecting combo type

                for (int zz = 1; zz <= matchCount; zz++) {
                    prevCounter = counter;
                    for (int yy = 0; yy < boardSizeY; yy++) 
                    {
                        for (int xx = 0; xx < boardSizeX; xx++) 
                        {
                            if (orbArr[xx, yy].matchNumber == zz) {
                                if (orbArr[xx, yy].orbObject != null) {
                                    mostRecentColor = orbArr[xx, yy].color;
                                    Destroy(orbArr[xx, yy].orbObject);
                                }
                                counter++;
                            }
                        }
                    }
                    
                    // Audio
                    if (counter != prevCounter) {   // Counting combos, it changed, new combo!

                        // Saturn gives +300 score
                        if (mostRecentColor == 0) {
                            GameObject scoreObject = GameObject.Find("Score_Text");
                            Score score = scoreObject.GetComponent<Score>();
                            score.IncreaseCount(300); 
                        }

                        // Supercomet gives +200 score
                        if (mostRecentColor == 1) {
                            GameObject scoreObject = GameObject.Find("Score_Text");
                            Score score = scoreObject.GetComponent<Score>();
                            score.IncreaseCount(200); 
                        }

                        // Ship gives 60 fuel
                        if (mostRecentColor == 2) {
                            GameObject fuelObject = GameObject.Find("Fuel_Text");
                            Fuel fuel = fuelObject.GetComponent<Fuel>();
                            fuel.IncreaseFuel(60); 
                        }

                        // Comet gives +100 score
                        if (mostRecentColor == 3) {
                            GameObject scoreObject = GameObject.Find("Score_Text");
                            Score score = scoreObject.GetComponent<Score>();
                            score.IncreaseCount(100); 
                        }

                        // UFO gives 120 fuel
                        if (mostRecentColor == 4) {
                            GameObject fuelObject = GameObject.Find("Fuel_Text");
                            Fuel fuel = fuelObject.GetComponent<Fuel>();
                            fuel.IncreaseFuel(120); 
                        }

                        comboCount++;
                        // TO-DO: USE AUDIO MANAGER
                        AudioSource[] audios = GetComponents<AudioSource>();
                        AudioSource audio = audios[1];
                        audio.pitch = pitch;
                        audio.Play(0);
                        pitch += 0.08f; // Raise the pitch for subsequent matches
                        yield return new WaitForSeconds(0.1f);
                    }

                    // Delay
                    yield return new WaitForSeconds(0.05f);
                }

                DropRemainingOrbs();
                DropNewOrbs();
            } else {
                yield return new WaitForSeconds(0.25f);
                boardIsLocked = false;
            }
        }

        /* =============================================================================================================
         *  Drop all of the orbs on the board from the empty space created from matching
         * =============================================================================================================
         */
        private void DropRemainingOrbs () {
            for (int y = 1; y < boardSizeY; y++) {
                for (int x = 0; x < boardSizeX; x++) {
                    if (orbArr[x, y].matchNumber > 0) continue;

                    int dropOrb = 0;
                    for (int i = 1; i <= y; i++) {
                        if (orbArr[x, y - i].matchNumber > 0)
                            dropOrb++;
                    }

                    if (dropOrb > 0) {
                        orbArr[x, y].dropDist = dropOrb;

                        Orb tempOrb = orbArr[x, y - dropOrb];
                        orbArr[x, y - dropOrb] = orbArr[x, y];
                        orbArr[x, y] = tempOrb;
                    }
                }
            }
        }

        /* =============================================================================================================
         *  Drop down newly spawned orbs from above after match is made and space is available
         * =============================================================================================================
         */
        private void DropNewOrbs () {
            for (int y = 4; y >= 0; y--) {
                for (int x = 0; x < boardSizeX; x++) {
                    if (orbArr[x, y].matchNumber > 0) {
                        SpawnOrb(x, y, 10);
                    }
                }
            }

            SkyfallOrbs();
            StartCoroutine(MatchOrbs());
        }
    }
}
// ---------------------------------
//         KeyHandler
// ---------------------------------
boolean[] keys;
int keyCount = 4;
void initKeys()
{
  keys = new boolean[keyCount];
  for (int i = 0; i < keyCount; i++) keys[i] = false;
}

void handleKeys()
{
  //movement
  PVector move = new PVector();
  if (keys[KEYS.W.val]) move.y -= 1;
  if (keys[KEYS.A.val]) move.x -= 1;
  if (keys[KEYS.S.val]) move.y += 1;
  if (keys[KEYS.D.val]) move.x += 1;
  move.normalize();
  p.move(move);
}

void keyPressed()
{
  if (key == 'w' || key == 'W') keys[KEYS.W.val] = true;
  if (key == 'a' || key == 'A') keys[KEYS.A.val] = true;
  if (key == 's' || key == 'S') keys[KEYS.S.val] = true;
  if (key == 'd' || key == 'D') keys[KEYS.D.val] = true;
  
  if(key == 'c' || key == 'C') exit();
}

void keyReleased()
{
  if (key == 'w' || key == 'W') keys[KEYS.W.val] = false;
  if (key == 'a' || key == 'A') keys[KEYS.A.val] = false;
  if (key == 's' || key == 'S') keys[KEYS.S.val] = false;
  if (key == 'd' || key == 'D') keys[KEYS.D.val] = false;
}

enum KEYS
{
  W(0), A(1), S(2), D(3);
  
  public int val;
  private KEYS(int value) { this.val = value; }
}

// ---------------------------------------
//     MouseHandler
// ---------------------------------------
boolean mouse = false;
PVector mouseVec;

void initMouse()
{
  mouseVec = new PVector(mouseX, mouseY);
}

void handleMouse()
{
  mouseVec.set(mouseX, mouseY);
}

void mousePressed()
{
  p.onMouseDown();
  mouse = true;
}

void mouseReleased()
{
  mouse = false;
}

// ---------------------------------------
//      CollisionHandler
// ---------------------------------------
ArrayList<Collider> coll;

boolean debug_showHitboxes = true;

void initCollisions()
{
  coll = new ArrayList<Collider>();
}

void handleCollisions()
{
  for(int i = 0; i < coll.size(); i++)
  {
    for(int j = i+1; j < coll.size(); j++)
    {
      if(((Collider)coll.get(i)).isColliding((Collider)coll.get(j)))
      {
        Collider left = (Collider)coll.get(i);
        Collider right = (Collider)coll.get(j);
        left.notifyCollision(right.tag);
        right.notifyCollision(left.tag);
      }
    }
    ((Collider)coll.get(i)).checkWall();
  }
}

void debugCollisions()
{
  if(!debug_showHitboxes) return;
  pushStyle();
  noFill();
  stroke(255,0,0);
  strokeWeight(5);
  for(Collider c : coll)
  {
    c.debug_show();
  }
  popStyle();
}

void addCollider(Collider col)
{
  coll.add(col);
}

void removeCollider(Collider col)
{
  coll.remove(col);
}

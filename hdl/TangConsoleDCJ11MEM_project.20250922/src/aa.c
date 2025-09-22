main(){
  int a, b, ca, cb, t;
  int f, p, q, s;
  int i, x, y;
  f = 50;
  putchar('\n');
  y = -12;
  while(y <= 12){
    x = -39;
    while(x <= 39){
      ca = x * 299 / 100;
      cb = y * 416 / 100;
      a = ca;
      b = cb;
      i=0;
      while(i <= 15){
        q = b / f; s = b - q*f;
        t = (a*a - b*b) / f + ca;
        b = 2 * (a*q + a*s/f) + cb;
        a = t;
        p= a / f; q= b / f;
        if((p*p + q*q) > 4){
          if(i > 9) i = i + 7;
          putchar(48 + i);
          i = 100;
        } else if(i == 15){
          putchar(' ');
        }
        i++;
      }
      x++;
    }
    putchar('\n');
    y++;
  }
}

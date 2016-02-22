RiemannSum ball1;
TrapezoidalRule ball2;
SimpsonsRule ball3;
Integration ball4;

void setup() {
  // fullScreen();
  // size(1213.5, 750);
  size(1214, 750);
  smooth();
  textFont(createFont("Source Code Pro", 12));

  float x = 20 + 100*width;
  float v = 30;
  float a = -0.075;
  float j = 0.00005;
  float s = -0.00000001;
  ball1 = new RiemannSum(x, 200, v, a, j, s);
  ball2 = new TrapezoidalRule(x, 300, v, a, j, s);
  ball3 = new SimpsonsRule(x, 400, v, a, j, s);
  ball4 = new Integration(x, 500, v, a, j, s);
}

void draw() {
  background(255);
  stroke(0);
  line(0, 100, width, 100);
  line(0, height - 100, width, height - 100);
  ball1.run();
  ball2.run();
  ball3.run();
  ball4.run();

  fill(255, 0, 0);
  text("Riemann Sum         error=" + (ball4.x() - ball1.x), 20, 20);
  fill(0, 255, 0);
  text("Trapezoidal Rule    error=" + (ball4.x() - ball2.x), 20, 40);
  fill(0, 0, 255);
  text("Simpson's Rule      error=" + (ball4.x() - ball3.x), 20, 60);
  fill(0);
  text("Integration         error=0", 20, 80);

  float[] pos = {ball1.x - ball4.x(), ball2.x - ball4.x(), ball3.x - ball4.x(), 0};
  float dist = max(abs(min(pos)), abs(max(pos)));
  for(int i = 0; i < pos.length; i++) {
    pos[i] = map(pos[i], -dist, dist, 20, width - 20);
  }
  stroke(255, 0, 0);
  line(pos[0], height - 100, pos[0], height);
  stroke(0, 255, 0);
  line(pos[1], height - 100, pos[1], height);
  stroke(0, 0, 255);
  line(pos[2], height - 100, pos[2], height);
  stroke(0);
  line(pos[3], height - 100, pos[3], height);
}

class RiemannSum {
  RiemannSum(float temp_x, float temp_y, float temp_v, float temp_a, float temp_j, float temp_s) {
    x = temp_x;
    x0 = x % width;
    y = temp_y;
    v = temp_v;
    a = temp_a;
    j = temp_j;
    s = temp_s;
  }

  void run() {
    j += s;
    a += j;
    v += a;
    x += v;

    float display_x = x % width;
    fill(255, 0, 0, 64);
    stroke(255, 0, 0);
    // line(display_x, 100, display_x, height - 100);
    ellipse(display_x, y, 20, 20);
  }

  float x, x0, y, v, a, j, s;
}

class TrapezoidalRule {
  TrapezoidalRule(float temp_x, float temp_y, float temp_v, float temp_a, float temp_j, float temp_s) {
    x = temp_x;
    x0 = x % width;
    y = temp_y;
    v = temp_v;
    pv = v;
    a = temp_a;
    pa = a;
    j = temp_j;
    pj = j;
    s = temp_s;
  }

  void run() {
    j += s;
    a += (pj + j) / 2.0;
    pj = j;
    v += (pa + a) / 2.0;
    pa = a;
    x += (pv + v) / 2.0;
    pv = v;

    float display_x = x % width;
    fill(0, 255, 0, 64);
    stroke(0, 255, 0);
    // line(display_x, 100, display_x, height - 100);
    ellipse(display_x, y, 20, 20);
  }

  float x, x0, y, v, pv, a, pa, j, pj, s;
}

class SimpsonsRule {
  SimpsonsRule(float temp_x, float temp_y, float temp_v, float temp_a, float temp_j, float temp_s) {
    t = 0;
    x = temp_x;
    x0 = x;
    y = temp_y;
    v = temp_v;
    pv = v;
    ppv = v;
    a = temp_a;
    pa = a;
    ppa = a;
    j = temp_j;
    pj = j;
    ppj = j;
    s = temp_s;
  }

  void run() {
    t++;
    if(t == 1) {
      j += s;
      a += (pj + j) / 2.0;
      pj = j;
      v += (pa + a) / 2.0;
      pa = a;
      x += (pv + v) / 2.0;
      pv = v;
    }
    else if (t == 2) {
      j += s;
      a = ppa + (ppj + 4*pj + j) / 3.0;
      ppj = pj;
      pj = j;
      v = ppv + (ppa + 4*pa + a) / 3.0;
      ppa = pa;
      pa = a;
      x = x0 + (ppv + 4*pv + v) / 3.0;
      ppv = pv;
      pv = v;
    }
    else {
      j += s;
      a += (-1*ppj + 8*pj + 5*j) / 12.0;
      ppj = pj;
      pj = j;
      v += (-1*ppa + 8*pa + 5*a) / 12.0;
      ppa = pa;
      pa = a;
      x += (-1*ppv + 8*pv + 5*v) / 12.0;
      ppv = pv;
      pv = v;
    }

    float display_x = x % width;
    fill(0, 0, 255, 64);
    stroke(0, 0, 255);
    // line(display_x, 100, display_x, height - 100);
    ellipse(display_x, y, 20, 20);
  }

  float x, x0, y, v, pv, ppv, a, pa, ppa, j, pj, ppj, s;
  int t;
}

class Integration {
  Integration(float temp_x, float temp_y, float temp_v, float temp_a, float temp_j, float temp_s) {
    t = 0;
    x0 = temp_x;
    y = temp_y;
    v0 = temp_v;
    a0 = temp_a;
    j0 = temp_j;
    s = temp_s;
  }

  float x() {
    return (1/24.0)*s*t*t*t*t + (1/6.0)*j0*t*t*t + (1/2.0)*a0*t*t +v0*t + x0;
  }

  void run() {
    t++;
    float display_x = x() % width;

    fill(0, 64);
    stroke(0);
    // line(x % width, 100, x % width, height - 100);
    ellipse(display_x, y, 20, 20);
  }

  float x0, y, v0, a0, j0, s;
  int t;
}

void mousePressed() {
  noLoop();
}

void mouseReleased() {
  loop();
}

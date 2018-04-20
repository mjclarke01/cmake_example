#ifndef REVERSER_H
#define REVERSER_H

template <class T>
T GetMax (T a, T b) {
  T result;
  result = (a>b)? a : b;
  return result;
}

#endif // REVERSER_H

int hash_1(int v) {
    v ^= v * 32063 >> 5;
    v ^= v * 51577 >> 2;
    v ^= v * 43573 >> 2;
    return v;
}

int hash_2(int x, int y) {
    return hash_1(x ^ hash_1(y));
}

int hash_3(int x, int y, int z) {
    return hash_1(z ^ hash_2(x, y));
}

int hash_4(int x, int y, int z, int w) {
    return hash_1(w ^ hash_3(x, y, z));
}

#define RANDOM_MOD (1u << 10u)

float u_random(int hash) {
    return float(uint(hash) % RANDOM_MOD) / float(RANDOM_MOD);
}

float s_random(int hash) {
    return u_random(hash) * 2.0 - 1.0;
}

float smooth_step(float v0, float v1, float f) {
	f = clamp(f, 0.0, 1.0);
	return v0 + (3.0 - f * 2.0) * f * f * (v1 - v0);
}

#include "gtest/gtest.h"

extern "C" int itoa(char *buffer, int number);
extern "C" int regwrapper(char *buffer, int number);
extern "C" int (*target_function)(char *buffer, int number);
extern "C" int bad_register;

TEST(itoa, zero) {
    char buff[100];
    target_function = itoa;

    int n = regwrapper(buff, 0);
    EXPECT_EQ(1, n);
    buff[n] = 0;
    EXPECT_STREQ("0", buff);
    EXPECT_EQ(0, bad_register);
}

TEST(itoa, single) {
    char buff[100];
    target_function = itoa;

    int n = regwrapper(buff, 1);
    EXPECT_EQ(1, n);
    buff[n] = 0;
    EXPECT_STREQ("1", buff);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(buff, 5);
    EXPECT_EQ(1, n);
    buff[n] = 0;
    EXPECT_STREQ("5", buff);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(buff, 9);
    EXPECT_EQ(1, n);
    buff[n] = 0;
    EXPECT_STREQ("9", buff);
    EXPECT_EQ(0, bad_register);
}

TEST(itoa, double) {
    char buff[100];
    target_function = itoa;

    int n = regwrapper(buff, 10);
    EXPECT_EQ(2, n);
    buff[n] = 0;
    EXPECT_STREQ("10", buff);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(buff, 19);
    EXPECT_EQ(2, n);
    buff[n] = 0;
    EXPECT_STREQ("19", buff);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(buff, 20);
    EXPECT_EQ(2, n);
    buff[n] = 0;
    EXPECT_STREQ("20", buff);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(buff, 55);
    EXPECT_EQ(2, n);
    buff[n] = 0;
    EXPECT_STREQ("55", buff);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(buff, 89);
    EXPECT_EQ(2, n);
    buff[n] = 0;
    EXPECT_STREQ("89", buff);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(buff, 99);
    EXPECT_EQ(2, n);
    buff[n] = 0;
    EXPECT_STREQ("99", buff);
    EXPECT_EQ(0, bad_register);
}

TEST(itoa, multi) {
    char buff[100];
    target_function = itoa;

    int n = regwrapper(buff, 100);
    EXPECT_EQ(3, n);
    buff[n] = 0;
    EXPECT_STREQ("100", buff);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(buff, 999);
    EXPECT_EQ(3, n);
    buff[n] = 0;
    EXPECT_STREQ("999", buff);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(buff, 123456);
    EXPECT_EQ(6, n);
    buff[n] = 0;
    EXPECT_STREQ("123456", buff);
    EXPECT_EQ(0, bad_register);

    n = regwrapper(buff, 987654321);
    EXPECT_EQ(9, n);
    buff[n] = 0;
    EXPECT_STREQ("987654321", buff);
    EXPECT_EQ(0, bad_register);
}

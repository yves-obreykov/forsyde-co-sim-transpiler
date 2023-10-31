
#include <stdio.h>
#include "circular_buffer.h" /* defines data type token as uint8_t */

/* Definition of the channel */
typedef cbuf_handle_t channel;

/* Definition of the functions 'readToken' and 'writeToken' */
int readToken(channel ch, token *data)
{
    return circular_buf_get(ch, data);
}

void writeToken(channel ch, token data)
{
    circular_buf_put(ch, data);
}

/* Definition of function 'createFIFO' */
channel createFIFO(token *buffer, size_t size)
{
    return circular_buf_init(buffer, size);
}


/* Definition of SDF actors */

/* actor 11 SDF has 1 input channel and 1 output channels */
void actor11SDF(int consum, int prod,
                channel *ch_in, channel *ch_out,
                void (*f)(token *, token *))
{
    token input[consum], output[prod];
    int i;

    for (i = 0; i < consum; i++)
    {
        readToken(*ch_in, &input[i]);
    }
    f(input, output);
    for (i = 0; i < prod; i++)
    {
        writeToken(*ch_out, output[i]);
    }
}

/* actor 12 SDF has 1 input channel and 2 output channels */
void actor12SDF(int consum, int prod1, int prod2,
                channel *ch_in, channel *ch_out1, channel *ch_out2,
                void (*f)(token *, token *, token *))
{
    token input[consum], output1[prod1], output2[prod2];
    int i;

    for (i = 0; i < consum; i++)
    {
        readToken(*ch_in, &input[i]);
    }
    f(input, output1, output2);
    for (i = 0; i < prod1; i++)
    {
        writeToken(*ch_out1, output1[i]);
    }
    for (i = 0; i < prod2; i++)
    {
        writeToken(*ch_out2, output2[i]);
    }
}

/* actor 13 SDF has 1 input channel and 3 output channels */
void actor13SDF(int consum, int prod1, int prod2, int prod3,
                channel *ch_in, channel *ch_out1, channel *ch_out2, channel *ch_out3,
                void (*f)(token *, token *, token *, token *))
{
    token input[consum], output1[prod1], output2[prod2], output3[prod3];
    int i;

    for (i = 0; i < consum; i++)
    {
        readToken(*ch_in, &input[i]);
    }
    f(input, output1, output2, output3);
    for (i = 0; i < prod1; i++)
    {
        writeToken(*ch_out1, output1[i]);
    }
    for (i = 0; i < prod2; i++)
    {
        writeToken(*ch_out2, output2[i]);
    }
    for (i = 0; i < prod3; i++)
    {
        writeToken(*ch_out3, output3[i]);
    }
}

/* actor 14 SDF has 1 input channel and 4 output channels */
void actor14SDF(int consum, int prod1, int prod2, int prod3, int prod4,
                channel *ch_in, channel *ch_out1, channel *ch_out2, channel *ch_out3, channel *ch_out4,
                void (*f)(token *, token *, token *, token *, token *))
{
    token input[consum], output1[prod1], output2[prod2], output3[prod3], output4[prod4];
    int i;

    for (i = 0; i < consum; i++)
    {
        readToken(*ch_in, &input[i]);
    }
    f(input, output1, output2, output3, output4);
    for (i = 0; i < prod1; i++)
    {
        writeToken(*ch_out1, output1[i]);
    }
    for (i = 0; i < prod2; i++)
    {
        writeToken(*ch_out2, output2[i]);
    }
    for (i = 0; i < prod3; i++)
    {
        writeToken(*ch_out3, output3[i]);
    }
    for (i = 0; i < prod4; i++)
    {
        writeToken(*ch_out4, output4[i]);
    }
}

/* actor 21 SDF has 2 input channels and 1 output channel */
void actor21SDF(int consum1, int consum2, int prod,
                channel *ch_in1, channel *ch_in2, channel *ch_out,
                void (*f)(token *, token *, token *))
{
    token input1[consum1], input2[consum2], output[prod];
    int i;

    for (i = 0; i < consum1; i++)
    {
        readToken(*ch_in1, &input1[i]);
    }
    for (i = 0; i < consum2; i++)
    {
        readToken(*ch_in2, &input2[i]);
    }
    f(input1, input2, output);
    for (i = 0; i < prod; i++)
    {
        writeToken(*ch_out, output[i]);
    }
}

/* actor 22 SDF has 2 input channels and 2 output channels */
void actor22SDF(int consum1, int consum2, int prod1, int prod2,                channel *ch_in1, channel *ch_in2, channel *ch_out1, channel *ch_out2,
                void (*f)(token *, token *, token *, token *))
{
    token input1[consum1], input2[consum2], output1[prod1], output2[prod2];
    int i;

    for (i = 0; i < consum1; i++)
    {
        readToken(*ch_in1, &input1[i]);
    }
    for (i = 0; i < consum2; i++)
    {
        readToken(*ch_in2, &input2[i]);
    }
    f(input1, input2, output1, output2);
    for (i = 0; i < prod1; i++)
    {
        writeToken(*ch_out1, output1[i]);
    }
    for (i = 0; i < prod2; i++)
    {
        writeToken(*ch_out2, output2[i]);
    }
}

/* actor 23 SDF has 2 input channels and 3 output channels */
void actor23SDF(int consum1, int consum2, int prod1, int prod2, int prod3,
                channel *ch_in1, channel *ch_in2, channel *ch_out1, channel *ch_out2, channel *ch_out3,
                void (*f)(token *, token *, token *, token *, token *))
{
    token input1[consum1], input2[consum2], output1[prod1], output2[prod2], output3[prod3];
    int i;

    for (i = 0; i < consum1; i++)
    {
        readToken(*ch_in1, &input1[i]);
    }
    for (i = 0; i < consum2; i++)
    {
        readToken(*ch_in2, &input2[i]);
    }
    f(input1, input2, output1, output2, output3);
    for (i = 0; i < prod1; i++)
    {
        writeToken(*ch_out1, output1[i]);
    }
    for (i = 0; i < prod2; i++)
    {
        writeToken(*ch_out2, output2[i]);
    }
    for (i = 0; i < prod3; i++)
    {
        writeToken(*ch_out3, output3[i]);
    }
}

/* actor 24 SDF has 2 input channels and 4 output channels */
void actor24SDF(int consum1, int consum2, int prod1, int prod2, int prod3, int prod4,
                channel *ch_in1, channel *ch_in2, channel *ch_out1, channel *ch_out2, channel *ch_out3, channel *ch_out4,
                void (*f)(token *, token *, token *, token *, token *, token *))
{
    token input1[consum1], input2[consum2], output1[prod1], output2[prod2], output3[prod3], output4[prod4];
    int i;

    for (i = 0; i < consum1; i++)
    {
        readToken(*ch_in1, &input1[i]);
    }
    for (i = 0; i < consum2; i++)
    {
        readToken(*ch_in2, &input2[i]);
    }
    f(input1, input2, output1, output2, output3, output4);
    for (i = 0; i < prod1; i++)
    {
        writeToken(*ch_out1, output1[i]);
    }
    for (i = 0; i < prod2; i++)
    {
        writeToken(*ch_out2, output2[i]);
    }
    for (i = 0; i < prod3; i++)
    {
        writeToken(*ch_out3, output3[i]);
    }
    for (i = 0; i < prod4; i++)
    {
        writeToken(*ch_out4, output4[i]);
    }
}

/* actor 31 SDF has 3 input channels and 1 output channel */
void actor31SDF(int consum1, int consum2, int consum3, int prod1,
                channel *ch_in1, channel *ch_in2, channel *ch_in3, channel *ch_out1,
                void (*f)(token *, token *, token *, token *))
{
    token input1[consum1], input2[consum2], input3[consum3], output1[prod1];
    int i;

    for (i = 0; i < consum1; i++)
    {
        readToken(*ch_in1, &input1[i]);
    }
    for (i = 0; i < consum2; i++)
    {
        readToken(*ch_in2, &input2[i]);
    }
    for (i = 0; i < consum3; i++)
    {
        readToken(*ch_in3, &input3[i]);
    }
    f(input1, input2, input3, output1);
    for (i = 0; i < prod1; i++)
    {
        writeToken(*ch_out1, output1[i]);
    }
}

/* actor 32 SDF has 3 input channels and 2 output channels */
void actor32SDF(int consum1, int consum2, int consum3, int prod1, int prod2,
                channel *ch_in1, channel *ch_in2, channel *ch_in3, channel *ch_out1, channel *ch_out2,
                void (*f)(token *, token *, token *, token *, token *))
{
    token input1[consum1], input2[consum2], input3[consum3], output1[prod1], output2[prod2];
    int i;

    for (i = 0; i < consum1; i++)
    {
        readToken(*ch_in1, &input1[i]);
    }
    for (i = 0; i < consum2; i++)
    {
        readToken(*ch_in2, &input2[i]);
    }
    for (i = 0; i < consum3; i++)
    {
        readToken(*ch_in3, &input3[i]);
    }
    f(input1, input2, input3, output1, output2);
    for (i = 0; i < prod1; i++)
    {
        writeToken(*ch_out1, output1[i]);
    }
    for (i = 0; i < prod2; i++)
    {
        writeToken(*ch_out2, output2[i]);
    }
}

/* actor 33 SDF has 3 input channels and 3 output channels */
void actor33SDF(int consum1, int consum2, int consum3, int prod1, int prod2, int prod3,
                channel *ch_in1, channel *ch_in2, channel *ch_in3, channel *ch_out1, channel *ch_out2, channel *ch_out3,
                void (*f)(token *, token *, token *, token *, token *, token *))
{
    token input1[consum1], input2[consum2], input3[consum3], output1[prod1], output2[prod2], output3[prod3];
    int i;

    for (i = 0; i < consum1; i++)
    {
        readToken(*ch_in1, &input1[i]);
    }
    for (i = 0; i < consum2; i++)
    {
        readToken(*ch_in2, &input2[i]);
    }
    for (i = 0; i < consum3; i++)
    {
        readToken(*ch_in3, &input3[i]);
    }
    f(input1, input2, input3, output1, output2, output3);
    for (i = 0; i < prod1; i++)
    {
        writeToken(*ch_out1, output1[i]);
    }
    for (i = 0; i < prod2; i++)
    {
        writeToken(*ch_out2, output2[i]);
    }
    for (i = 0; i < prod3; i++)
    {
        writeToken(*ch_out3, output3[i]);
    }
}

/* actor 34 SDF has 3 input channels and 4 output channels */
void actor34SDF(int consum1, int consum2, int consum3, int prod1, int prod2, int prod3, int prod4,
                channel *ch_in1, channel *ch_in2, channel *ch_in3, channel *ch_out1, channel *ch_out2, channel *ch_out3, channel *ch_out4,
                void (*f)(token *, token *, token *, token *, token *, token *, token *))
{
    token input1[consum1], input2[consum2], input3[consum3], output1[prod1], output2[prod2], output3[prod3], output4[prod4];
    int i;

    for (i = 0; i < consum1; i++)
    {
        readToken(*ch_in1, &input1[i]);
    }
    for (i = 0; i < consum2; i++)
    {
        readToken(*ch_in2, &input2[i]);
    }
    for (i = 0; i < consum3; i++)
    {
        readToken(*ch_in3, &input3[i]);
    }
    f(input1, input2, input3, output1, output2, output3, output4);
    for (i = 0; i < prod1; i++)
    {
        writeToken(*ch_out1, output1[i]);
    }
    for (i = 0; i < prod2; i++)
    {
        writeToken(*ch_out2, output2[i]);
    }
    for (i = 0; i < prod3; i++)
    {
        writeToken(*ch_out3, output3[i]);
    }
    for (i = 0; i < prod4; i++)
    {
        writeToken(*ch_out4, output4[i]);
    }
}

/* actor 41 SDF has 4 input channels and 1 output channel */
void actor41SDF(int consum1, int consum2, int consum3, int consum4, int prod1,
                channel *ch_in1, channel *ch_in2, channel *ch_in3, channel *ch_in4, channel *ch_out1,
                void (*f)(token *, token *, token *, token *, token *))
{
    token input1[consum1], input2[consum2], input3[consum3], input4[consum4], output1[prod1];
    int i;

    for (i = 0; i < consum1; i++)
    {
        readToken(*ch_in1, &input1[i]);
    }
    for (i = 0; i < consum2; i++)
    {
        readToken(*ch_in2, &input2[i]);
    }
    for (i = 0; i < consum3; i++)
    {
        readToken(*ch_in3, &input3[i]);
    }
    for (i = 0; i < consum4; i++)
    {
        readToken(*ch_in4, &input4[i]);
    }
    f(input1, input2, input3, input4, output1);
    for (i = 0; i < prod1; i++)
    {
        writeToken(*ch_out1, output1[i]);
    }
}

/* actor 42 SDF has 4 input channels and 2 output channels */
void actor42SDF(int consum1, int consum2, int consum3, int consum4, int prod1, int prod2,
                channel *ch_in1, channel *ch_in2, channel *ch_in3, channel *ch_in4, channel *ch_out1, channel *ch_out2,
                void (*f)(token *, token *, token *, token *, token *, token *))
{
    token input1[consum1], input2[consum2], input3[consum3], input4[consum4], output1[prod1], output2[prod2];
    int i;

    for (i = 0; i < consum1; i++)
    {
        readToken(*ch_in1, &input1[i]);
    }
    for (i = 0; i < consum2; i++)
    {
        readToken(*ch_in2, &input2[i]);
    }
    for (i = 0; i < consum3; i++)
    {
        readToken(*ch_in3, &input3[i]);
    }
    for (i = 0; i < consum4; i++)
    {
        readToken(*ch_in4, &input4[i]);
    }
    f(input1, input2, input3, input4, output1, output2);
    for (i = 0; i < prod1; i++)
    {
        writeToken(*ch_out1, output1[i]);
    }
    for (i = 0; i < prod2; i++)
    {
        writeToken(*ch_out2, output2[i]);
    }
}

/* actor 43 SDF has 4 input channels and 3 output channels */
void actor43SDF(int consum1, int consum2, int consum3, int consum4, int prod1, int prod2, int prod3,
                channel *ch_in1, channel *ch_in2, channel *ch_in3, channel *ch_in4, channel *ch_out1, channel *ch_out2, channel *ch_out3,
                void (*f)(token *, token *, token *, token *, token *, token *, token *))
{
    token input1[consum1], input2[consum2], input3[consum3], input4[consum4], output1[prod1], output2[prod2], output3[prod3];
    int i;

    for (i = 0; i < consum1; i++)
    {
        readToken(*ch_in1, &input1[i]);
    }
    for (i = 0; i < consum2; i++)
    {
        readToken(*ch_in2, &input2[i]);
    }
    for (i = 0; i < consum3; i++)
    {
        readToken(*ch_in3, &input3[i]);
    }
    for (i = 0; i < consum4; i++)
    {
        readToken(*ch_in4, &input4[i]);
    }
    f(input1, input2, input3, input4, output1, output2, output3);
    for (i = 0; i < prod1; i++)
    {
        writeToken(*ch_out1, output1[i]);
    }
    for (i = 0; i < prod2; i++)
    {
        writeToken(*ch_out2, output2[i]);
    }
    for (i = 0; i < prod3; i++)
    {
        writeToken(*ch_out3, output3[i]);
    }
}

/* actor 44 SDF has 4 input channels and 4 output channels */
void actor44SDF(int consum1, int consum2, int consum3, int consum4, int prod1, int prod2, int prod3, int prod4,
                channel *ch_in1, channel *ch_in2, channel *ch_in3, channel *ch_in4, channel *ch_out1, channel *ch_out2, channel *ch_out3, channel *ch_out4,
                void (*f)(token *, token *, token *, token *, token *, token *, token *, token *))
{
    token input1[consum1], input2[consum2], input3[consum3], input4[consum4], output1[prod1], output2[prod2], output3[prod3], output4[prod4];
    int i;

    for (i = 0; i < consum1; i++)
    {
        readToken(*ch_in1, &input1[i]);
    }
    for (i = 0; i < consum2; i++)
    {
        readToken(*ch_in2, &input2[i]);
    }
    for (i = 0; i < consum3; i++)
    {
        readToken(*ch_in3, &input3[i]);
    }
    for (i = 0; i < consum4; i++)
    {
        readToken(*ch_in4, &input4[i]);
    }
    f(input1, input2, input3, input4, output1, output2, output3, output4);
    for (i = 0; i < prod1; i++)
    {
        writeToken(*ch_out1, output1[i]);
    }
    for (i = 0; i < prod2; i++)
    {
        writeToken(*ch_out2, output2[i]);
    }
    for (i = 0; i < prod3; i++)
    {
        writeToken(*ch_out3, output3[i]);
    }
    for (i = 0; i < prod4; i++)
    {
        writeToken(*ch_out4, output4[i]);
    }
}

<?xml version="1.0" encoding="UTF-8"?>

<!--  Copyright (c) 2014, STMicroelectronics International N.V. -->
<!--  All rights reserved. -->
<!--  -->
<!--  Redistribution and use in source and binary forms, with or without -->
<!--  modification, are permitted provided that the following conditions are met: -->
<!--  -->
<!--  1. Redistributions of source code must retain the above copyright notice, -->
<!--  this list of conditions and the following disclaimer. -->
<!--  -->
<!--  2. Redistributions in binary form must reproduce the above copyright notice, -->
<!--  this list of conditions and the following disclaimer in the documentation -->
<!--  and/or other materials provided with the distribution. -->
<!--  -->
<!--  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" -->
<!--  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE -->
<!--  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE -->
<!--  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE -->
<!--  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR -->
<!--  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF -->
<!--  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS -->
<!--  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN -->
<!--  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) -->
<!--  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE -->
<!--  POSSIBILITY OF SUCH DAMAGE. -->

<xsl:stylesheet version="1.0"
xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="text"/>
<xsl:strip-space elements="*"/>
<xsl:param name="target"/>

<xsl:template match="package">
<xsl:text>
/*
 * Copyright (c) 2014, STMicroelectronics International N.V.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License Version 2 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
 */


#include &lt;stdio.h&gt;
#include &lt;string.h&gt;
#include &lt;stdlib.h&gt;
#include &lt;sys/types.h&gt;
#include &lt;unistd.h&gt;
#include "xtest_test.h"
#include "xtest_helpers.h"
#include "ta_testingClientAPI_test.h"
#undef TA_UUID
#include "ta_answerSuccessTo_OpenSession_Invoke_test.h"
#undef TA_UUID
#include "tee_api_defines.h"
#include "tee_client_api.h"
#include "xml_client_api.h"

static bool xtest_init = false;

</xsl:text>
static bool xtest_tee_init(ADBG_Case_t *c)
{
    if (xtest_init) {
        return true;
    }
    SHARE_MEM01 = malloc(sizeof(TEEC_SharedMemory));
    if (!ADBG_EXPECT_NOT_NULL(c, SHARE_MEM01)) {
        goto exit;
    }
    SHARE_MEM02 = malloc(sizeof(TEEC_SharedMemory));
    if (!ADBG_EXPECT_NOT_NULL(c, SHARE_MEM02)) {
        goto exit;
    }
    SESSION01 = malloc(sizeof(TEEC_Session));
    if (!ADBG_EXPECT_NOT_NULL(c, SESSION01)) {
        goto exit;
    }
    CONTEXT01 = malloc(sizeof(TEEC_Context));
    if (!ADBG_EXPECT_NOT_NULL(c, CONTEXT01)) {
        goto exit;
    }
    OPERATION01 = malloc(sizeof(TEEC_Operation));
    if (!ADBG_EXPECT_NOT_NULL(c, OPERATION01)) {
        goto exit;
    }
    OPERATION02 = malloc(sizeof(TEEC_Operation));
    if (!ADBG_EXPECT_NOT_NULL(c, OPERATION02)) {
        goto exit;
    }

    xtest_init = true;

    return xtest_init;

exit:
    if (SHARE_MEM01) {
      free(SHARE_MEM01);
      SHARE_MEM01 = NULL;
    }
    if (SHARE_MEM02) {
      free(SHARE_MEM02);
      SHARE_MEM02 = NULL;
    }
    if (SESSION01) {
      free(SESSION01);
      SESSION01 = NULL;
    }
    if (CONTEXT01) {
      free(CONTEXT01);
      CONTEXT01 = NULL;
    }
    if (OPERATION01) {
      free(OPERATION01);
      OPERATION01 = NULL;
    }
    if (OPERATION02) {
      free(OPERATION02);
      OPERATION02 = NULL;
    }

    xtest_init = false;
    return xtest_init;
}

static void xtest_tee_deinit(void)
{
    if (SHARE_MEM01) {
      free(SHARE_MEM01);
      SHARE_MEM01 = NULL;
    }
    if (SHARE_MEM02) {
      free(SHARE_MEM02);
      SHARE_MEM02 = NULL;
    }
    if (SESSION01) {
      free(SESSION01);
      SESSION01 = NULL;
    }
    if (CONTEXT01) {
      free(CONTEXT01);
      CONTEXT01 = NULL;
    }
    if (OPERATION01) {
      free(OPERATION01);
      OPERATION01 = NULL;
    }
    if (OPERATION02) {
      free(OPERATION02);
      OPERATION02 = NULL;
    }

    xtest_init = false;
}



<xsl:for-each select="initial-state/scenario">
/*<xsl:value-of select="substring(substring-after(./@name, '('), 0, 9)" />*/
static void xtest_tee_<xsl:value-of select="position()+7000" />(ADBG_Case_t *c)
{
<xsl:text>    if (!ADBG_EXPECT_TRUE(c, xtest_tee_init(c)))
        return ;
</xsl:text>
<xsl:for-each select="./body/call/operation">
    <xsl:apply-templates select="."></xsl:apply-templates>
</xsl:for-each>
<xsl:if test="position()=last()"><xsl:text>    xtest_tee_deinit();</xsl:text></xsl:if>
}
</xsl:for-each>

<xsl:for-each select="initial-state/scenario">
<xsl:variable name="position" select="position()+7000" />
ADBG_CASE_DEFINE(gp, <xsl:value-of select="$position" />, xtest_tee_<xsl:value-of select="$position" /><xsl:text>, "</xsl:text><xsl:value-of select="substring(substring-after(./@name, '('), 0, 9)" /><xsl:text>");</xsl:text>
</xsl:for-each>
</xsl:template>

<xsl:template match="operation">
<xsl:choose>
<!--Call an operation with ADBG_EXPECT() macro.-->
<xsl:when test="(contains(./argument[last()]/parameter/@name, 'xpected') and not(contains(./@name, 'Invoke')) and not(contains(./@name, 'checkMemoryContent_sharedMemory')) and not(contains(./@name, 'checkMemoryContent_tmpMemory')) and not(contains(./@name, 'checkContent_Parameter_value')) and not(contains(./@name, 'OpenSession')) and not(contains(./@name, 'InitializeContext')))">    ADBG_EXPECT(c, <xsl:for-each select="./argument"><xsl:if test="position()=last()"><xsl:apply-templates select="value"></xsl:apply-templates></xsl:if></xsl:for-each>, <xsl:apply-templates select="./@name"></xsl:apply-templates><xsl:for-each select="./argument/value"><xsl:if test="position()>1 and not(position()=last())">, </xsl:if><xsl:if test="not(position()=last())"><xsl:apply-templates select="."></xsl:apply-templates></xsl:if>
        </xsl:for-each>));
</xsl:when>
<xsl:otherwise>
<xsl:text>    </xsl:text><xsl:apply-templates select="./@name"></xsl:apply-templates><xsl:for-each select="./argument"><xsl:if test="position()>1">, </xsl:if>
            <xsl:apply-templates select="./value"></xsl:apply-templates>
        </xsl:for-each>);
</xsl:otherwise>
</xsl:choose>

</xsl:template>

<xsl:template match="value">
<xsl:choose>
<!--xsl:when test=".='IN_sharedMem_size'"><xsl:value-of select="./@name" />
</xsl:when-->
<xsl:when test="(contains(./@name, 'UUID'))"><xsl:text>&amp;</xsl:text><xsl:value-of select="./@name" />
</xsl:when>
<xsl:when test="(../type/@name='ALL_TEE_NAMES' and ./@name='NULL')"><xsl:text>_device</xsl:text>
</xsl:when>
<xsl:otherwise>
<!--xsl:text>&amp;</xsl:text--><xsl:value-of select="./@name" />
</xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="parameter">
        <xsl:value-of select="./@name" />
</xsl:template>

<xsl:template match="@name">
<xsl:choose>
<xsl:when test=".='ctx_init_finalize'"><xsl:text>thr2_ctx.c = c;
    thr2_ctx.ctx = CONTEXT01;
    </xsl:text><xsl:value-of select="." /><xsl:text>(</xsl:text>
</xsl:when>
<xsl:when test=".='RequestCancellation'"><xsl:value-of select="." /><xsl:text>(</xsl:text>
</xsl:when>
<xsl:when test=".='InitializeContext'"><xsl:text>XML_</xsl:text><xsl:value-of select="." /><xsl:text>(c, </xsl:text>
</xsl:when>
<xsl:when test=".='OpenSession'"><xsl:text>XML_</xsl:text><xsl:value-of select="." /><xsl:text>(c, </xsl:text>
</xsl:when>
<xsl:when test=".='Invoke_Remember_Expected_ParamTypes'"><xsl:text>INVOKE_REMEMBER_EXP_PARAM_TYPES</xsl:text><xsl:text>(</xsl:text>
</xsl:when>
<xsl:when test=".='AllocateSharedMemory'"><xsl:value-of select="." /><xsl:text>(</xsl:text>
</xsl:when>
<xsl:when test=".='RegisterSharedMemory'"><xsl:value-of select="." /><xsl:text>(</xsl:text>
</xsl:when>
<xsl:when test=".='AllocateTempMemory'"><xsl:value-of select="." /><xsl:text>(</xsl:text>
</xsl:when>
<xsl:when test=".='ReleaseTempMemory'"><xsl:value-of select="." /><xsl:text>(</xsl:text>
</xsl:when>
<xsl:when test=".='PARAM_TYPES'"><xsl:text>OPERATION_TEEC_PARAM_TYPES</xsl:text><xsl:text>(</xsl:text>
</xsl:when>
<xsl:when test="(contains(., 'Invoke') and not(contains(., 'Remember_Expected_ParamTypes')))"><xsl:text>XML_InvokeCommand</xsl:text><xsl:text>(c, </xsl:text>
</xsl:when>
<xsl:otherwise>
<xsl:text>TEEC_</xsl:text><xsl:value-of select="." /><xsl:text>(</xsl:text>
</xsl:otherwise>
</xsl:choose>
</xsl:template>

</xsl:stylesheet>

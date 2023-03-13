<?php

declare (strict_types = 1);

namespace App\Service;

use Ezijing\HyperfExcel\Core\Constants\ExcelConstant;
use Ezijing\HyperfExcel\Core\Services\Excel;

class ExcelService
{
    /**
     * @var Excel
     */
    protected $excel;

    public function __construct()
    {
        $this->excel = make(Excel::class);
    }

    public function download($name = '', $data = [], $key = [], $title = [])
    {
        $tableName = $name;
        $data = [
            'export_way' => ExcelConstant::SAVE_TO_A_LOCAL_DIRECTORY,
            'enable_number' => false,
            'titles' => $title,
            'keys' => $key,
            'data' => $data,
            // 验证规则, 本地导入也适用
            'value_type' => [
                // 强转string
                // ['key' => 'position', 'type' => 'string'],
                // 强转int
                ['key' => 'id', 'type' => 'int'],
                // 回调处理
                [
                    'key' => 'department',
                    'type' => 'function',
                    'func' => function ($value) {
                        return (string) $value;
                    },
                ],
            ],
        ];

        return $this->excel->exportExcelForASingleSheet($tableName, $data);
    }
}
